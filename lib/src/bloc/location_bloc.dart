import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_friends_location/src/bloc/user_provider.dart';
import 'package:live_friends_location/src/models/user_model.dart';
import 'package:live_friends_location/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'user_bloc.dart';

class LocationBLoc {
  Repository _repository = Repository();
  Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream =
      FirebaseFirestore.instance.collection('userslist').snapshots();

  final _outputPosition = BehaviorSubject<Set<Marker>>();
  final _startingPosition = BehaviorSubject<Position>();

  final _positionFetcher = Geolocator.getPositionStream(
    locationSettings:
        LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 4),
  );

  Stream<Set<Marker>> get outputPosition => _outputPosition.stream;

  Stream<Position> get startingPosition => _startingPosition.stream;

  Function(Position) get changeStartingPosition => _startingPosition.sink.add;

  LocationBLoc() {
    // storePosition();
    collectionStream.transform(_commentsTransformer()).pipe(_outputPosition);

    _positionFetcher.listen((newPosition) {
      print("new eevene = $newPosition");
      updateUser(newPosition);
    });
  }

  fetchPermission() async {
    var pos = await _repository.getPermission();
    changeStartingPosition(pos);
  }

  loadImage(imgurl) async {
    return (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
        .buffer
        .asUint8List();
  }

  _commentsTransformer() {
    return ScanStreamTransformer(
      (Set<Marker> cache, QuerySnapshot<Map<String, dynamic>> dtaa, index) {
        cache.clear();
        Iterable lst = dtaa.docs;
        for (var i in lst) {
          // UserModel usr = UserModel.fromJson(i);
          LatLng latLng = LatLng(i['latitude'], i['longitude']);
          print("name = ${i['name']}");
          String imgurl = i['imageLink'];
          // Uint8List bytes = loadImage(imgurl);
          cache.add(
            Marker(
              markerId: MarkerId(latLng.toString()),
              position: latLng,
              infoWindow:
                  InfoWindow(title: '${i['name']}', snippet: 'Hi ${i['name']}'),
              //  icon: BitmapDescriptor.defaultMarker,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),

              // icon: BitmapDescriptor.fromAssetImage( ImageConfiguration(),, 'assetName'),
            ),
          );
        } //     var usr = UserModel.fromJson(itm);

        return cache;
      },
      <Marker>{},
    );
  }

  // Stream<Position> get userPosition => _positionFetcher.transform(_itemTransformer());

  getCurrentLocation() async {
    await fetchPermission();
    changeStartingPosition(await Geolocator.getCurrentPosition());
  }

  storePosition() {
    _positionFetcher.listen((newPosition) {
      print("new eevene = $newPosition");
      updateUser(newPosition);
    });
  }

  Future<void> updateUser(Position newPosition) {
    var users = FirebaseFirestore.instance.collection('userslist');

    return users
        .doc(loggedInUserId)
        .update({
          'latitude': newPosition.latitude,
          'longitude': newPosition.longitude,
        })
        .then((value) => print("User coordinates Updated"))
        .catchError(
            (error) => print("Failed to update user cordinated: $error"));
  }
}

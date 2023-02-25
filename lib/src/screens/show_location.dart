import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/bloc_providers/location_provider.dart';
import '../bloc/user_provider.dart';
import '../resources/location_controller.dart';
import '../models/user_model.dart';

class ShowLocation extends StatelessWidget {
  const ShowLocation({Key? key}) : super(key: key);

  // late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    final locationBloc = LocationProvider.of(context);

    final userBLoc = UserProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Showing your current location"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Consumer<GetLocation>(builder: (context, dtaa, child) {
          //   return ElevatedButton(
          //     onPressed: () async {
          //       print("response = ${await dtaa.determinePosition()}");
          //     },
          //     child: Text("Get Location"),
          //   );
          // }),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          // Flexible(
          //   fit: FlexFit.loose,
          //   child: StreamBuilder(
          //     stream: locationBloc.outputPosition,
          //     builder: (BuildContext context, snapshot) {
          //       if (snapshot.hasError) {
          //         return Text('Something went wrong');
          //       }
          //
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Text("Loading");
          //       }
          //
          //       return Text("snapshot data = ${snapshot.data}");
          //       // return ListView.builder(
          //       //   itemCount: docs.length,
          //       //   itemBuilder: (context, index) {
          //       //     if (!snapshot.hasData) {
          //       //       return Text("Future builder dont have data");
          //       //     }
          //       //     var itm = docs[index].data();
          //       //     var usr = UserModel.fromJson(itm);
          //       //     return Text("snapshot = ${usr.id}");
          //       //   },
          //       // );
          //     },
          //   ),
          // ),
          Flexible(
            fit: FlexFit.loose,
            child: StreamBuilder(
                stream: locationBloc.startingPosition,
                builder: (context, snapshot1) {
                  if (!snapshot1.hasData) {
                    return Text("Wait getting your location");
                  }
                  return StreamBuilder(
                    stream: locationBloc.outputPosition,
                    builder: (context, snapshot) {
                      print("snapshot dta = ${snapshot.data}");
                      if (!snapshot.hasData) {
                        return Text("Waiting for Friends coordinates");
                      }

                      return Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GoogleMap(
                              // onMapCreated: _onMapCreated,
                                compassEnabled: true,
                                mapToolbarEnabled: true,
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(snapshot1.data!.latitude,
                                      snapshot1.data!.longitude),
                                  zoom: 14.0,
                                ),
                                gestureRecognizers: //
                                <Factory<OneSequenceGestureRecognizer>>{
                                  Factory<OneSequenceGestureRecognizer>(
                                        () => EagerGestureRecognizer(),
                                  ),
                                },
                                markers: snapshot.data!

                              // onTap: (ltlong){
                              //   policeLocation = ltlong;
                              //   // _currentMapPosition=ltlong;
                              //   _onAddPoliceMarker();
                              // },

                              // onCameraMove: _onCameraMove
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

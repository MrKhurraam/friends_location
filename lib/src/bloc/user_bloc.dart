import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:live_friends_location/src/models/user_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/location_controller.dart';
import '../resources/user_firebase.dart';
import 'validators.dart';

var loggedInUserId;

// Validators is a mixin
class UserBloc extends Object with Validators {
  final _userFirebase = UserFirebase();
  final _locationController = GetLocation();
  late bool permissionStatus;
  late Position position;

  final _name = BehaviorSubject<String>();
  final _loggedIn = BehaviorSubject<bool>();
  final _password = BehaviorSubject<String>();
  final _imageLink = BehaviorSubject<File>();
  final _email = BehaviorSubject<String>();
  final _userId = BehaviorSubject<String>();

  Stream<String> get name => _name.stream;

  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get loggedIn => _loggedIn.stream;

  Stream<File> get imageLink => _imageLink.stream;

  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get userId => _userId.stream;

  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (a, b) {
        print("a = $a , b = $b");
        return true;
      });

  // Change Data

  UserBloc() {
    // _loggedIn.sink.add(false);
  }

  Function(String) get changeName => _name.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(File) get changeImage => _imageLink.sink.add;

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changeId => _userId.sink.add;

  Function(bool) get changeLoggedState => _loggedIn.sink.add;

  signUp() async {
    try {
      Position currentPosition = await _locationController.getCurrentLocation();
      position = currentPosition;
      print("Position = $currentPosition");
      // if (permissionStatus) {
      UserModel userModel = UserModel(
        name: _name.value,
        password: _password.value,
        email: _email.value,
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
      );
      var uidd = await _userFirebase.signUp(userModel);
      userModel.id = uidd;
      changeId(uidd!);
      var imgUrl = await _userFirebase.addUserImage(_imageLink.value);
      userModel.imageLink = imgUrl;
      await _userFirebase.addNewUser(userModel, uidd);

      return 1;
      // }
      // throw Exception("Permission not granted");
    } catch (e) {
      throw Exception(e);
    }
  }

  signIn() async {
    try {
      var uidd = await _userFirebase.signIn(_email.value, _password.value);
      changeId(uidd);
      return 1;
    } catch (e) {
      throw Exception(e);
    }
  }

  dispose() {
    _name.close();
    _password.close();
    _userId.close();
    _email.close();
    _imageLink.close();
  }
}

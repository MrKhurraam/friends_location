import 'dart:async';

import '../resources/user_firebase.dart';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) async {
    UserFirebase userFirebase = UserFirebase();
    var rs = await userFirebase.getUser(email);
    if (rs == 0) {
      sink.add(email);
    } else {
      sink.addError("Email already exist");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 5) {
      sink.add(password);
    } else {
      sink.addError("Password must be greater than 5 digits");
    }
  });
}

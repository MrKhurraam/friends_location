import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_friends_location/src/bloc/user_provider.dart';
import '../../firebase_options.dart';
import '../bloc/bloc_providers/location_provider.dart';
import '../bloc/user_bloc.dart';

class InitializeFirebase {
  InitializeFirebase(context) {
    init(context);
  }

  init(context) async {
    final userBloc = UserProvider.of(context);
    final locationBloc = LocationProvider.of(context);
    await locationBloc.fetchPermission();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        print("logged in true");
        userBloc.changeLoggedState(true);
        loggedInUserId = user.uid;
      } else {
        userBloc.changeLoggedState(false);
        print("logged in false");
      }
    });
  }
}

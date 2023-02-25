import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:live_friends_location/src/bloc/bloc_providers/location_provider.dart';

import '../models/user_model.dart';
import '../widgets/common_dialogs.dart';

class UserFirebase {
  fetchUsers() {}

  late String userId;

  signIn(String username, String password) async {
    try {
      // ShowDialog.showLoadingDialog(title: "Loading", context: context);
      print("name = ${username}, username = ${password}");

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      // Navigator.pop(context);
      log('return credentials = ${credential}');
      userId = credential.user!.uid.toString();
      return userId;
      // Navigator.of(context).pushNamed('/DisplayProfiles');
    } on FirebaseAuthException catch (e) {
      // Navigator.pop(context);
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        throw Exception('No user found for that email.');

        // ShowDialog.showErrorDialog(
        //     description: 'user-not-found', context: context);
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        throw Exception('Wrong password provided for that user');
        // ShowDialog.showErrorDialog(
        //     description: 'Wrong password', context: context);
      } else {
        // ShowDialog.showErrorDialog(
        //     description: 'Invalid Data', context: context);
        // print("unknown exception  = $e");
        throw Exception('unknown Error Occured');
      }
    }
  }

  Future<String?> signUp(UserModel userModel) async {
    print("signUp usermodel = $userModel");
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email.trim(),
        password: userModel.password.trim(),
      );
      userId = credential.user!.uid;
      print("authenticated , userid = $userId");
      return userId;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      print("unknown exception  = $e");
      throw Exception('Unknown Error Occurs');
    }
  }

  Future<String> addUserImage(File image) async {
    try {
      // Extract image name from image cache url
      var pathimage = image.toString();
      var temp = pathimage.lastIndexOf('/');
      var result = pathimage.substring(temp + 1);
      print("result = $result");

      // Saving image in firebase storage
      final ref =
          FirebaseStorage.instance.ref().child('UserImages').child(result);
      var response1 = await ref.putFile(image);
      print("Updated $response1");
      var imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      throw Exception(e);
    }
  }

  addNewUser(UserModel userModel, id) async {
    try {
      print("addNewUser userModel = $userModel");
      await FirebaseFirestore.instance
          .collection('userslist')
          .doc(id)
          .set(userModel.toJson());
      // var response = await FirebaseFirestore.instance
      //     .collection('userslist')
      //     .add(userModel.toJson());
      // print("Firebase response1111 ${response.id}");
    } catch (e) {
      log("Exception occur : ${e}");
      throw Exception('Error in adding new user');
    }
  }

  Future<int> getUser(String email) async {
    final response = await FirebaseFirestore.instance
        .collection('userlist')
        .where('email', isEqualTo: email)
        .get();
    print("getUser response = ${response.size}");
    if (response.size == 0) return 0;
    return 1;
  }
}

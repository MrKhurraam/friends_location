import 'dart:io';

import 'package:geolocator/geolocator.dart';

class UserModel {
  late String? id;
  final String? name;
  final String password;
  late String? imageLink;
  final String email;
  final double? latitude;
  final double? longitude;

  UserModel(
      {required this.password,
      this.name,
      this.id,
      required this.email,
      this.imageLink,
      this.latitude,
      this.longitude});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          password: json['password'] as String,
          imageLink: json['imageLink'] as String,
          email: json['email'] as String,
          latitude: json['latitude'] as double,
          longitude: json['longitude'] as double,
        );

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
      'imageLink': imageLink,
      'name': name,
      'id': id,
      'longitude': longitude,
      'latitude': latitude
    };
  }
}

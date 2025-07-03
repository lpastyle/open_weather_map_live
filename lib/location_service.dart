import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService {

// get users's position
  Future<LocationData?> getPosition() async {
    // when working with iOS simulator check menu Feature/Location/Apple
    try {
      Location location = Location();
      return location.getLocation();
    } on PlatformException catch (error) {
      debugPrint("unable to get user's location : ${error.message}");
      return null;
    }
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:open_weather_map_live/geo_position.dart';
import 'package:geocoding/geocoding.dart' as geocoding; // alias nécessaire car symboles aussi definis dans 'location'


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

  // convert lat,lon to city name
  Future<GeoPosition?> getCity() async {
    final LocationData? position = await getPosition();
    // if location service fails, use harcoded position
    // final LocationData position = LocationData.fromMap({
    //   "latitude": 48.8566,
    //   "longitude": 2.3522,
    // });
    final double lat = position?.latitude ?? 0;
    final double lon = position?.longitude ?? 0;
    List<geocoding.Placemark> placemark = await geocoding.placemarkFromCoordinates(lat, lon);
    debugPrint(placemark.toString());
    final firstPlace = placemark.first;
    return GeoPosition(
      city: firstPlace.locality ?? "", 
      lat: lat,
      lon: lon);
  }

}
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CurrentLocation {
  static double latitute = 0.0;
  static double longitude = 0.0;
  static Placemark place = Placemark();
  static bool haspermission = true;

  static Future<void> checkGps() async {
    haspermission = true;
    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!servicestatus) {
      haspermission = false;
      await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      haspermission = false;
    }

    if (haspermission) {
      getLocationCoordinates();
    }
  }

  static Future<void> getLocationCoordinates() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    log(position.longitude.toString());
    log(position.latitude.toString());

    longitude = position.longitude;
    latitute = position.latitude;
  }

  static Future<Placemark> getAddress({lat, long}) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) place = placemarks[0];
    } catch (err) {
      log(err.toString());
    }
    return place;
  }
}

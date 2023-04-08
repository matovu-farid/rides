import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rides/utils/location/current_location.dart';

class CenterLocation extends ChangeNotifier {
  double? latitude;
  double? longitude;

  updateCurrent() async {
    var value = await getCurrentLocation();

    latitude = value.latitude;
    longitude = value.longitude;
    notifyListeners();
  }

  void updateLocation(LatLng center) {
    latitude = center.latitude;
    longitude = center.longitude;
    notifyListeners();
  }
}

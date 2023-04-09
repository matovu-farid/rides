import 'package:geolocator/geolocator.dart';
import 'package:rides/models/center_location.dart';
import 'package:rides/models/rides.dart';

String calculateDistance(CenterLocation pointOne, Ride pointTwo) {
  double distanceInMeters = Geolocator.distanceBetween(pointOne.latitude!,
      pointOne.longitude!, pointTwo.latitude, pointTwo.longitude);
  return (distanceInMeters / 1000).toStringAsFixed(2);
}

import 'package:geolocator/geolocator.dart';
import 'package:rides/models/center_location.dart';
import 'package:rides/models/rides.dart';

double calculateDistance(CenterLocation pointOne, Ride pointTwo) {
  double distanceInMeters = Geolocator.distanceBetween(pointOne.latitude!,
      pointOne.longitude!, pointTwo.latitude, pointTwo.longitude);
  return distanceInMeters;
}

import 'package:geolocator/geolocator.dart';

double calculateDistance(Position pointOne, Position pointTwo) {
  double distanceInMeters = Geolocator.distanceBetween(pointOne.latitude,
      pointOne.longitude, pointTwo.latitude, pointTwo.longitude);
  return distanceInMeters;
}

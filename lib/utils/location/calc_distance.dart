import 'package:geolocator/geolocator.dart';
import 'package:rides/models/rides.dart';

double calculateDistance(Position pointOne, Ride pointTwo) {
  double distanceInMeters = Geolocator.distanceBetween(pointOne.latitude,
      pointOne.longitude, pointTwo.latitude, pointTwo.longitude);
  return distanceInMeters;
}

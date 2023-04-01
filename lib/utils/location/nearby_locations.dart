import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

List<Position> generateLocations(
    Position center, double minSpacing, int numberOfLocations) {
  List<Position> locations = [];
  final Distance distance = Distance();

  for (int i = 0; i < numberOfLocations; i++) {
    double bearing = 360 * i / numberOfLocations; // equally distributed angles
    LatLng centerLatLng = LatLng(center.latitude, center.longitude);
    LatLng newLatLng = distance.offset(centerLatLng, minSpacing, bearing);

    locations.add(Position(
      latitude: newLatLng.latitude,
      longitude: newLatLng.longitude,
      timestamp: center.timestamp,
      accuracy: center.accuracy,
      altitude: center.altitude,
      heading: center.heading,
      speed: center.speed,
      speedAccuracy: center.speedAccuracy,
    ));
  }

  return locations;
}

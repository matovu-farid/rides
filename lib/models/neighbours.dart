import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:rides/models/rides.dart';
import 'package:rides/utils/location/nearby_locations.dart';

class Neighbour {
  final Position center;
  final Position position;
  final Ride ride;
  Neighbour({
    required this.center,
    required this.position,
    required this.ride,
  });
}

Future<List<Neighbour>> getNeighbours(Position center) async {
  var locations = generateLocations(center, 100, 50);
  final rides = await getRides();
  List<Neighbour> neighbours = [];
  for (var location in locations) {
    var ride = Random().nextInt(rides.length);
    var neighbour = Neighbour(
      center: center,
      position: location,
      ride: rides[ride],
    );
    neighbours.add(neighbour);
  }
  return neighbours;
}

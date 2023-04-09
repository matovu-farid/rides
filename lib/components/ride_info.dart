import 'package:flutter/material.dart';
import 'package:rides/models/center_location.dart';
import 'package:rides/models/rides.dart';
import 'package:rides/utils/location/calc_distance.dart';
import 'package:provider/provider.dart';

class RideInfo extends StatelessWidget {
  final Ride ride;

  const RideInfo(this.ride, {super.key});

  @override
  Widget build(BuildContext context) {
    var center = context.watch<CenterLocation>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          child: Column(children: [
        ListTile(
          title: Text(ride.name),
        ),
        ListTile(
          title: Text(ride.make),
        ),
        ListTile(
          title: Text(ride.model),
        ),
        ListTile(
          title: Text("${calculateDistance(center, ride)} km away"),
        ),
      ])),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rides/models/center_location.dart';
import 'package:rides/models/rides.dart';
import 'package:provider/provider.dart';

import '../utils/location/calc_distance.dart';

class RidePage extends StatelessWidget {
  final Ride ride;
  const RidePage({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    var center = context.watch<CenterLocation>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Ride Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              child: Column(children: [
            ListTile(
              title: Text("Name: ${ride.name}"),
            ),
            ListTile(
              title: Text("Make: ${ride.make}"),
            ),
            ListTile(
              title: Text("Model: ${ride.model}"),
            ),
            ListTile(
              title:
                  Text("Distance: ${calculateDistance(center, ride)} km away"),
            ),
          ])),
        ));
  }
}

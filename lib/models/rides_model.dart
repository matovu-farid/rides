import 'package:flutter/material.dart';
import 'package:rides/models/center_location.dart';
import 'package:rides/models/rides.dart';

class RidesModel extends ChangeNotifier {
  List<Ride> rides = [];
  updateRides(CenterLocation center) {
    fetchNeighbors(center, 10).listen((data) {
      rides = getRides(data);
    });
  }
}

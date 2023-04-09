import 'package:flutter/material.dart';
import 'package:rides/models/center_location.dart';
import 'package:rides/models/rides.dart';

class RidesModel extends ChangeNotifier {
  List<Ride>? _rides;
  List<Ride>? get rides => _rides;
  updateRides(CenterLocation center) {
    fetchNeighbors(center, 10).listen((data) {
      _rides = getRides(data);
      notifyListeners();
    });
  }
}

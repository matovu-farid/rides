import 'package:flutter/material.dart';
import 'package:rides/models/center_location.dart';
import 'package:rides/models/rides.dart';

class RidesModel extends ChangeNotifier {
  List<Ride>? _rides;
  List<Ride>? get rides => _rides;
  int timesFetched = 0;

  double radius = 10;
  updateRadius(double value, CenterLocation center) {
    radius = value;
    updateRides(center);
  }

  updateRides(CenterLocation center) {
    fetchNeighbors(center, radius).listen((data) {
      _rides = getRides(data);

      notifyListeners();
    });
    // Expand the search radius if no rides are found
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if ((_rides == null || _rides!.isEmpty) && timesFetched < 10) {
        timesFetched++;
        updateRadius(radius * 1.2, center);
      }
    });
  }
}

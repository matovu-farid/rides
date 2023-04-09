import 'package:flutter/material.dart';

import 'package:rides/models/center_location.dart';

import 'package:provider/provider.dart';
import 'package:rides/models/rides.dart';
import 'package:rides/models/rides_model.dart';

class RidesWrapper extends StatelessWidget {
  final Widget Function(List<Ride> rides, CenterLocation center) builder;

  const RidesWrapper({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CenterLocation>(builder: (context, center, _) {
      if (center.latitude != null && center.longitude != null) {
        return Consumer<RidesModel>(builder: (context, model, _) {
          if (model.rides == null) {
            model.updateRides(center);
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return builder(model.rides!, center);
        });
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

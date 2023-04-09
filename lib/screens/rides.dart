import 'package:flutter/material.dart';
import 'package:rides/components/ride_info.dart';
import 'package:rides/components/rides_wrapper.dart';

class RidesPage extends StatelessWidget {
  const RidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Rides'),
      ),
      body: RidesWrapper(
        builder: (neighbours, _) => ListView.builder(
            itemBuilder: (context, index) {
              var ride = neighbours[index];
              return RideInfo(ride);
            },
            itemCount: neighbours.length),
      ),
    );
  }
}

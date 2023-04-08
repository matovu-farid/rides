import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rides/components/map_component.dart';
import 'package:rides/models/rides.dart';
import 'dart:async';

import 'package:rides/utils/location/current_location.dart';

class MapComponent extends StatefulWidget {
  const MapComponent({Key? key}) : super(key: key);

  @override
  State<MapComponent> createState() => MapState();
}

class MapState extends State<MapComponent> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Future<List<BitmapDescriptor>> getIcons(imageConfiguration) {
    return Future.wait([
      BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/car.png'),
      BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/truck.png'),
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, 'assets/electriccar.png'),
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, 'assets/electrictruck.png')
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context, size: const Size.square(48));
    return Scaffold(
      body: FutureBuilder<Position>(
          future: getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            var center = snapshot.data;
            if (snapshot.connectionState == ConnectionState.done &&
                center != null) {
              return StreamBuilder<List<DocumentSnapshot<Object?>>>(
                  stream: fetchNeighbors(center, 10),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    var dataGot = snapshot.data;
                    if (snapshot.hasData && dataGot != null) {
                      var neighbours = getRides(dataGot);

                      return FutureBuilder<List<BitmapDescriptor>>(
                          future: getIcons(imageConfiguration),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              var icons = snapshot.data;
                              if (icons != null) {
                                return MapFigure(
                                  center: center,
                                  neighbours: neighbours,
                                  icons: icons,
                                );
                              }
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

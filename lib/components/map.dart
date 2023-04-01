import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position>(
          future: getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            var position = snapshot.data;
            if (snapshot.connectionState == ConnectionState.done &&
                position != null) {
              var target = LatLng(position.latitude, position.longitude);
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: target,
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('current_location'),
                    position: target,
                  ),
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

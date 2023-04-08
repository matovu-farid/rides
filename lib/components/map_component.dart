import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rides/models/rides.dart';
import 'package:rides/utils/location/calc_distance.dart';

class MapFigure extends StatefulWidget {
  const MapFigure({
    Key? key,
    required this.center,
    required this.neighbours,
    required this.icons,
  }) : super(key: key);

  final Position center;
  final List<Ride> neighbours;
  final List<BitmapDescriptor> icons;

  @override
  State<MapFigure> createState() => _MapFigureState();
}

class _MapFigureState extends State<MapFigure> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  BitmapDescriptor getIcon(Ride ride) {
    if (ride.size == 'small' && ride.make == 'fuel') {
      return widget.icons[0];
    } else if (ride.size == 'small' && ride.make == 'electric') {
      return widget.icons[2];
    } else if (ride.size == 'big' && ride.make == 'fuel') {
      return widget.icons[1];
    } else {
      return widget.icons[3];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.center.latitude,
          widget.center.longitude,
        ),
        zoom: 13,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: {
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(
            widget.center.latitude,
            widget.center.longitude,
          ),
        ),
        for (Ride neighbour in widget.neighbours)
          Marker(
            markerId: MarkerId(neighbour.id),
            position: LatLng(
              neighbour.latitude,
              neighbour.longitude,
            ),
            infoWindow: InfoWindow(
              title: neighbour.name,
              snippet:
                  " make: ${neighbour.make}\n model: ${neighbour.model}\n size: ${neighbour.size}\n distance: ${calculateDistance(widget.center, neighbour)} km \n location: ${neighbour.latitude}, ${neighbour.longitude}",
            ),
            icon: getIcon(neighbour),
          )
      },
    );
  }
}

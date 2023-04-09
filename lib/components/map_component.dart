import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rides/models/center_location.dart';
import 'package:rides/models/rides.dart';
import 'package:rides/models/rides_model.dart';
import 'package:rides/utils/location/calc_distance.dart';

class MapFigure extends StatefulWidget {
  const MapFigure({
    Key? key,
    // required this.center,

    required this.icons,
  }) : super(key: key);

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

  double zoom = 13;

  @override
  Widget build(BuildContext context) {
    var center = context.watch<CenterLocation>();
    var neighbours = context.watch<RidesModel>().rides!;
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              center.latitude!,
              center.longitude!,
            ),
            zoom: zoom,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            Marker(
              draggable: true,
              markerId: const MarkerId('current_location'),
              position: LatLng(
                center.latitude!,
                center.longitude!,
              ),
              onDrag: (value) {
                center.updateLocation(value);
              },
            ),
            for (Ride neighbour in neighbours)
              Marker(
                markerId: MarkerId(neighbour.id),
                position: LatLng(
                  neighbour.latitude,
                  neighbour.longitude,
                ),
                infoWindow: InfoWindow(
                  title: neighbour.name,
                  snippet:
                      " make: ${neighbour.make}\n model: ${neighbour.model}\n size: ${neighbour.size}\n dist (km): ${calculateDistance(center, neighbour)}",
                ),
                icon: getIcon(neighbour),
              )
          },
        ),
        // Update zoom
        Positioned(
          top: 10,
          right: 10,
          child: FloatingActionButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.zoomIn(),
              );
              setState(() {
                zoom++;
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
        Positioned(
          top: 70,
          right: 10,
          child: FloatingActionButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.zoomOut(),
              );
              setState(() {
                zoom--;
              });
            },
            child: const Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}

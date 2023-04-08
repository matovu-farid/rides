import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:rides/models/center_location.dart';

class Ride {
  String make;
  String model;
  String name;
  String size;
  double latitude;
  double longitude;
  String id;

  Ride({
    required this.make,
    required this.model,
    required this.name,
    required this.size,
    required this.latitude,
    required this.longitude,
    required this.id,
  });
  String toString() {
    return "\n\{ name: $name,\n make: $make,\n model: $model,\n size: $size,\n latitude: $latitude,\n longitude: $longitude \n}";
  }

  // Factory constructor to create a Rides instance from a Firestore snapshot
  factory Ride.fromFirestore(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    GeoPoint coordinates = data['position']['geopoint'];

    return Ride(
      make: data['make'],
      model: data['model'],
      name: data['name'],
      size: data['size'],
      id: snapshot.id,
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
    );
  }
}

Stream<List<DocumentSnapshot>> fetchNeighbors(
    CenterLocation center, double radius) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final geo = GeoFlutterFire();
  CollectionReference neighboursRef = firestore.collection('neighbours');

  GeoFirePoint centerPoint =
      geo.point(latitude: center.latitude!, longitude: center.longitude!);
  Stream<List<DocumentSnapshot>> stream = geo
      .collection(collectionRef: neighboursRef)
      .within(
          center: centerPoint,
          radius: radius,
          field: 'position',
          strictMode: true);

  return stream;
}

List<Ride> getRides(List<DocumentSnapshot<Object?>> snapshots) {
  List<Ride> rides =
      snapshots.map((snapshot) => Ride.fromFirestore(snapshot)).toList();
  return rides;
}

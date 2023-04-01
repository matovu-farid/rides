import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  final String make;
  final String size;
  final String name;
  final String model;

  Ride(
      {required this.make,
      required this.size,
      required this.name,
      required this.model});

  factory Ride.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Ride(
      make: data['make'],
      size: data['size'],
      name: data['name'],
      model: data['model'],
    );
  }
}

Future<List<Ride>> getRides() async {
  final ridesCollection = FirebaseFirestore.instance.collection('cars');
  final ridesData = await ridesCollection.get();

  final rides = ridesData.docs.map((doc) => Ride.fromFirestore(doc)).toList();
  return rides;
}

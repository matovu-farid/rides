import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String make;
  final String model;
  final String year;
  final String name;
  Car(this.make, this.year, this.model, this.name);
  Car.fromJson(Map<String, dynamic> json)
      : make = json['make'],
        model = json['model'],
        year = json['year'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'make': make,
        'model': model,
        'year': year,
        'name': name,
      };
  @override
  String toString() {
    return this.name;
  }
}

class Cars {
  final List<Car> cars;
  Cars(this.cars);
  Cars.fromJson(List<dynamic> json)
      : cars = json.map((i) => Car.fromJson(i)).toList();
  @override
  String toString() {
    return this.cars.toString();
  }
}

// generate point between max and min latitudes and longitudes
List<double> generatePoint(double minLat, double maxLat, double minLong,
    double maxLong, int precision) {
  final random = Random();
  final lat = minLat + random.nextDouble() * (maxLat - minLat);
  final long = minLong + random.nextDouble() * (maxLong - minLong);
  return [
    double.parse(lat.toStringAsFixed(precision)),
    double.parse(long.toStringAsFixed(precision))
  ];
}

// create car upto the limit with logitude and latitude that is saved to firebase
void createData(int limit, String input) async {
  //var input = await File('./data.json').readAsString();
  var cars = jsonDecode(input);

  final geo = GeoFlutterFire();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  for (var i = 0; i < limit; i++) {
    // genrate a random car
    var car = cars[Random().nextInt(cars.length)];

    // generatePoint in Uganda
    var point = generatePoint(0.2, 0.4, 32.0, 34.0, 6);

    GeoFirePoint myLocation =
        geo.point(latitude: point[0], longitude: point[1]);
    firestore
        .collection('neighbours')
        .add({...car, 'position': myLocation.data});
  }
}

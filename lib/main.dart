import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rides/components/map.dart';
import 'package:rides/firebase_options.dart';
import 'package:rides/models/center_location.dart';
import 'package:rides/routes.dart';
import 'package:rides/screens/home.dart';
import 'package:rides/screens/map.dart';
import 'package:rides/screens/rides.dart';
import 'package:rides/utils/genData.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // File('/Users/faridmatovu/projects/rides/assets/data.json')
    //     .readAsString()
    //     .then((value) => createData(100, value));

    return ChangeNotifierProvider<CenterLocation>(
      create: (context) => CenterLocation()..updateCurrent(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.home: (context) => const MyHomePage(),
          AppRoutes.map: (context) => const MapPage(),
          AppRoutes.rides: (context) => const RidesPage()
        },
      ),
    );
  }
}

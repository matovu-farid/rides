import 'package:flutter/material.dart';
import 'package:rides/components/custom_icon.dart';
import 'package:rides/routes.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  static const iconDataSet = {
    {'key': 'Fuel Small car', 'path': 'assets/car.png'},
    {'key': 'Fuel Big car', 'path': 'assets/truck.png'},
    {'key': 'Electric Small car', 'path': 'assets/electriccar.png'},
    {'key': 'Electric Big car', 'path': 'assets/electrictruck.png'}
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Text(
                'Keys to map',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              for (var iconData in iconDataSet)
                Card(
                  child: ListTile(
                    title: Text(iconData['key']!,
                        style: const TextStyle(fontSize: 16)),
                    leading: CustomIcon(assetPath: iconData['path']!, size: 60),
                  ),
                ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.map);
                    },
                    child: const Text('View Map'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.rides);
                    },
                    child: const Text('Near Rides'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

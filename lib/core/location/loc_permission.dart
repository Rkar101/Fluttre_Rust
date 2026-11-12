import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:meta/meta.dart';

class LocPermission with ChangeNotifier {
  // Use static so you can call LocPermission.requestLoc() directly
  static Future<void> requestLoc() async {
    bool locService = await Geolocator.isLocationServiceEnabled();

    final status = await Geolocator.requestPermission();

    if (status == LocationPermission.denied) {
      print('Location permission granted.');
    } else if (status == LocationPermission.deniedForever) {
      print('Location permanently denied. Opening settings...');
      await openAppSettings();
    }
  }

  locationData() {}
}

import 'package:geolocator/geolocator.dart';

class LocationRegionService {

  static Future<String> getUserRegionVN() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "Không xác định"; 
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Không xác định"; 
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return "Không xác định";
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final double lat = position.latitude;

    if (lat >= 17.0) {
      return "HN";
    } else {
      return "HCM";
    }
  }
}

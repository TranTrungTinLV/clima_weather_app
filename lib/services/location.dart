import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longtitude;

  Future<void> getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longtitude = position.longitude;
      print(latitude);
      print(longtitude);
    } catch (e) {
      print(e);
    }
  }
}

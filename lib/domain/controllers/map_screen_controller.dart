import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final isMapLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final mapController = StateProvider<MapScreenController>((ref) {
  return MapScreenController(ref: ref);
});

class MapScreenController {
  Ref ref;
  MapScreenController({
    required this.ref,
  });
  double? long = 0.0;
  double? lat = 0.0;

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    long = position.longitude;
    lat = position.latitude;
  }
}

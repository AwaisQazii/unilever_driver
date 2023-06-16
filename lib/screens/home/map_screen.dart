import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unilever_driver/domain/controllers/map_screen_controller.dart';
import 'package:unilever_driver/utils/assets.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  Set<Marker> markers = {};

  initialization() async {
    final permission = await Permission.location.status;
    if (permission == PermissionStatus.denied) {
      await Permission.location.request();
    } else {}

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(isMapLoadingProvider.notifier).state = true;
      await ref.read(mapController.notifier).state.getLocation();
      await addMarker();
      ref.read(isMapLoadingProvider.notifier).state = false;
    });
  }

  @override
  void initState() {
    initialization();
    super.initState();
  }

  addMarker() async {
    final controller = ref.read(mapController.notifier).state;

    final markerIcon = await getBytesFromAsset(AssetsPath.rider, 100);

    markers.add(
      Marker(
        markerId: const MarkerId('userLocation'),
        position: LatLng(controller.lat, controller.long),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: const InfoWindow(title: 'User Name'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isMapLoadingProvider);
    final controller = ref.watch(mapController);

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                zoom: 20.0,
                target: LatLng(
                  controller.lat,
                  controller.long,
                ),
              ),
              onMapCreated: (controller) {},
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              markers: markers,
            ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}

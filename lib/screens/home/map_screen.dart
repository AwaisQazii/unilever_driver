import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
  LatLng? startPosition;
  LatLng? endPosition;
  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> polyCoordinates = [];

  addMarker() async {
    final controller = ref.read(mapController.notifier).state;
    final markerIcon = await getBytesFromAsset(AssetsPath.rider, 100);
    if (controller.long != null) {
      startPosition = LatLng(controller.lat!, controller.long!);
      endPosition = const LatLng(24.918120539237268, 67.09755264222622);
      markers.addAll({
        Marker(
          markerId: const MarkerId('userLocation'),
          position: startPosition!,
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: const InfoWindow(title: 'User Name'),
        ),
        Marker(
          markerId: const MarkerId('destination'),
          position: endPosition!,
          infoWindow: const InfoWindow(title: 'User Name'),
        ),
      });
      getPolyLines();
    }
  }

  getPolyLines() async {
    PolylinePoints polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDV9f-USFHNWFssklMBhi8x7vm_P7nTMT4",
      PointLatLng(startPosition!.latitude, startPosition!.longitude),
      PointLatLng(endPosition!.latitude, endPosition!.longitude),
    );
    log("${startPosition!.latitude} latitude user");

    if (result.points.isNotEmpty) {
      for (PointLatLng element in result.points) {
        polyCoordinates.add(LatLng(element.longitude, element.latitude));
      }
    }
    log("${result.status} result status");

    PolylineId id = PolylineId("id");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polyCoordinates,
      width: 5,
    );

    polyLines[id] = polyline;
  }

  initialization() async {
    final permission = await Permission.location.status;
    if (permission == PermissionStatus.denied) {
      await Permission.location.request();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        ref.read(isMapLoadingProvider.notifier).state = true;
        await ref.read(mapController.notifier).state.getLocation();
        await addMarker();
        ref.read(isMapLoadingProvider.notifier).state = false;
      });
    }
  }

  @override
  void initState() {
    initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isMapLoadingProvider);
    final controller = ref.watch(mapController);

    return Scaffold(
      body: SafeArea(
        child: isLoading && controller.long == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  zoom: 20.0,
                  target: LatLng(
                    controller.lat!,
                    controller.long!,
                  ),
                ),
                myLocationButtonEnabled: false,
                onMapCreated: (controller) {},
                onTap: (argument) {
                  log("${argument.latitude} - long : ${argument.longitude}");
                },
                polylines: Set<Polyline>.of(polyLines.values),
                zoomControlsEnabled: false,
                markers: markers,
              ),
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

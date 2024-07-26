import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_background/src/android_config.dart' as fb;

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



  void _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('Location permission granted');
    } else if (status.isDenied) {
      print('Location permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Location permission permanently denied');
      openAppSettings();
    }
  }

  void _startBackgroundTask() async {
    print("asd");
    const androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "Background Location",
      notificationText: "App is running in the background",
      notificationImportance: fb.AndroidNotificationImportance.Default,
      notificationIcon: fb.AndroidResource(
          name: 'background_icon',
          defType: 'drawable'
      ),
    );
    bool hasPermissions = await FlutterBackground.initialize(androidConfig: androidConfig);
    if (hasPermissions) {
      FlutterBackground.enableBackgroundExecution();
      _startLocationUpdates();
      print("Background task started");
    }else{
      print("Background task failed");
    }
  }

  void _startLocationUpdates() {
    print("start location update");
    Timer.periodic(const Duration(seconds: 30), (Timer timer) async {
      print('Timer ticked at ${DateTime.now()}');
      try {
        var permissionStatus = await Permission.location.status;
        print('Location permission status: $permissionStatus');
        if (permissionStatus.isGranted) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          print(
              'Current location: Latitude: ${position.latitude}, Longitude: ${position.longitude}');
        } else {
          print('Location permission is not granted');
        }
      } catch (e) {
        print('Error fetching location: $e');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _startBackgroundTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        buildingsEnabled: true,
        trafficEnabled: true,
        mapType: MapType.satellite,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: _kGooglePlex,
      ),
    );
  }
}

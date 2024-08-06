import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_background/src/android_config.dart' as fb;
import 'package:http/http.dart' as http;

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

  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    getMyLocation();
    _requestPermission();
    _startBackgroundTask();
    _loadDirections();
  }

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
    print("Starting background task...");
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
    } else {
      print("Background task failed");
    }
  }

  void _startLocationUpdates() {
    print("Starting location updates...");
    Timer.periodic(const Duration(seconds: 30), (Timer timer) async {
      print('Timer ticked at ${DateTime.now()}');
      try {
        var permissionStatus = await Permission.location.status;
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

  Future<List<LatLng>> _getDirections(double startLat, double startLng, double endLat, double endLng) async {
    const String apiKey = 'YOUR_GOOGLE_MAPS_API_KEY'; // Replace with your actual API key
    final url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final encodedPoints = data['routes'][0]['overview_polyline']['points'];
      return _decodePolyline(encodedPoints);
    } else {
      throw Exception('Failed to load directions');
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polylinePoints = [];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < encoded.length) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      LatLng p = LatLng(
        (lat / 1E5).toDouble(),
        (lng / 1E5).toDouble(),
      );
      polylinePoints.add(p);
    }

    return polylinePoints;
  }

  void _loadDirections() async {
    final startLat = 37.42796133580664;
    final startLng = -122.085749655962;
    final endLat = 34.0522;
    final endLng = -118.2437;

    final points = await _getDirections(startLat, startLng, endLat, endLng);

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId('route'),
          points: points,
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }
  LatLng _initialPosition = LatLng(37.7749, -122.4194); // Default location (San Francisco)
  late Position _currentPosition;

  getMyLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _initialPosition = LatLng(_currentPosition.latitude, _currentPosition.longitude);
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _initialPosition,
          zoom: 14.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            buildingsEnabled: true,
            trafficEnabled: true,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.0,
            ),
            polylines: _polylines,
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: (){
                getMyLocation();
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[400]!.withOpacity(0.8),
                  shape: BoxShape.circle
                ),
                child: const Center(
                  child: Icon(Icons.my_location,color: Colors.black,),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_background/flutter_background.dart';
import "package:flutter_background/src/android_config.dart" as fb;
import 'package:provider/provider.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/features/screens/home/tickets/task_details.dart';
import '../../controllers/ticket_controllers.dart';
import '../../models/ticket_model.dart';
import '../../providers/processing_tickets_provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _startBackgroundTask();
    getProcessingTickets();
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
      notificationIcon:
          fb.AndroidResource(name: 'background_icon', defType: 'drawable'),
    );
    bool hasPermissions =
        await FlutterBackground.initialize(androidConfig: androidConfig);
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

  final LatLng _initialPosition = const LatLng(
      48.76312862329226, 9.160379099401501);

  final Set<Marker> _markers = {};

  Future<void> getProcessingTickets() async {
    var provider =
        Provider.of<ProcessingTicketsProvider>(context, listen: false);

    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.getProcessingTickets(context);
    res.fold((failure) {
      // Handle failure
    }, (tickets) {
      provider.addTickets(tickets);

      for (var ticket in tickets) {
        var latitude = double.parse(ticket.client!.latitude);
        var longitude = double.parse(ticket.client!.longitude);
        var markerId = MarkerId(ticket.id!);

        Marker marker = Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: markerId,
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: ticket.client!.user!.fullname,
            snippet: ticket.serviceCompany!.companyName,
          ),
          onTap: (){
            Timer(Duration(seconds: 2),(){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>TaskDetails(ticketModel: ticket)));
            });
          }
        );

        _markers.add(marker);
      }
      setState(() {});
    });
  }


  final LatLngBounds germanyBounds = LatLngBounds(
    southwest: const LatLng(47.2701114, 5.8663425), // Southwest corner
    northeast: const LatLng(55.058347, 15.041896), // Northeast corner
  );

  GoogleMapController? googleMapController;

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  bool mapOptHidden = false;

  void _goToLocation(dynamic lat, dynamic lng) {
    if (googleMapController != null) {
      googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, lng),
            zoom: 12.0,
          ),
        ),
      );
    } else {
      print("GoogleMapController is not ready.");
    }
  }

  @override
  Widget build(BuildContext context) {
    var processingTicketProvider =
        Provider.of<ProcessingTicketsProvider>(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapToolbarEnabled: true,
              buildingsEnabled: false,
              trafficEnabled: true,
              mapType: MapType.normal,
              zoomControlsEnabled: mapOptHidden==true?false:true,
              myLocationEnabled: true,
              myLocationButtonEnabled: mapOptHidden==true?false:true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                googleMapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 14.0,
              ),
              // polylines: _polylines,
              markers: _markers,
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mapOptHidden=!mapOptHidden;
                  });
                },
                child: Visibility(
                  visible: mapOptHidden==true?false:true,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Icon(
                        Icons.list_alt_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 5,
              right: 5,
              child: Visibility(
                visible: mapOptHidden,
                child: Container(
                  height: 200,
                  width: getPhoneWitdth(context),
                  decoration: const BoxDecoration(color: Colors.black87),
                  child: ListView(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Task List",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  mapOptHidden=!mapOptHidden;
                                });
                              },
                              child: const Icon(
                                Icons.clear,
                                size: 30,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: processingTicketProvider
                          .getProcessingTickets()
                          .length,
                      itemBuilder: (context, index) {
                        TicketModel ticketModel = processingTicketProvider
                            .getProcessingTickets()[index];
                        return GestureDetector(
                          onTap: () {
                            double latitude =
                                double.parse(ticketModel.client!.latitude);
                            double longitude =
                                double.parse(ticketModel.client!.longitude);
                            _goToLocation(latitude, longitude);
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.all(5),
                            width: getPhoneWitdth(context),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.task,
                                      size: 25,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${ticketModel.client!.user!.fullname}, ${ticketModel.serviceCompany!.companyName}, ${ticketModel.client!.description}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          ticketModel.client!.address,
                                          style: const TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.location_on,
                                  size: 25,
                                  color: Colors.redAccent,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

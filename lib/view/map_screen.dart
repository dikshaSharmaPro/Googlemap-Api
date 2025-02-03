import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:map/config/app_image.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng _initialPosition = const LatLng(0.0, 0.0);
  late Position _currentPosition;
  final Set<Marker> _markers = {};
  final List<String> _carIcons = [
    AppImage.carIcon,
    AppImage.carImg,
    AppImage.carPreImg,
    AppImage.carIcon4,
    AppImage.carIcon5,
    AppImage.carIcon6,
    AppImage.carIcon7,
  ];
  List<Uint8List> markerIcons = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadCarIcons();
    Get.snackbar("Tap on the cab", "Get driver details");
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current location
    _currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _initialPosition =
          LatLng(_currentPosition.latitude, _currentPosition.longitude);
      _addCarMarkers(_initialPosition);
    });
  }

  Future<void> _loadCarIcons() async {
    for (String iconPath in _carIcons) {
      ByteData byteData = await rootBundle.load(iconPath);
      Uint8List byteList = byteData.buffer.asUint8List();
      // Add the loaded icon to the marker icon set
      markerIcons.add(byteList);
    }
  }

  void _addCarMarkers(LatLng position) {
    final Random random = Random();
    const double distance = 0.01; // 1km in degrees

    for (int i = 0; i < 10; i++) {
      final double latOffset = (random.nextDouble() - 0.5) * distance;
      final double lngOffset = (random.nextDouble() - 0.5) * distance;
      final LatLng randomPosition =
          LatLng(position.latitude + latOffset, position.longitude + lngOffset);

      // Select a random icon from the loaded marker icons
      final Uint8List markerIcon =
          markerIcons[random.nextInt(markerIcons.length)];

      _markers.add(
        Marker(
          markerId: MarkerId('car_$i'),
          position: randomPosition,
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: 'Car $i',
            snippet: "Tap for more info | 5 min away",
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const UserDetailsDialog(
                    userName: 'John Doe',
                    userEmail: 'john.doe@example.com',
                    userImage: 'assets/user_image.jpg',
                  );
                },
              );
            },
          ),
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Cab'),
      ),
      body:
          _initialPosition.latitude == 0.0 && _initialPosition.longitude == 0.0
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 17.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                ),
    );
  }
}

class UserDetailsDialog extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userImage;

  const UserDetailsDialog({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Driver Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppImage.cabDriver),
            ),
          ),
          const SizedBox(height: 20),
          Text('Name: $userName'),
          const SizedBox(height: 10),
          Text('Email: $userEmail'),
          const SizedBox(height: 10),
          const Text('Rating: 5'),
          const SizedBox(height: 10),
          const Text('Total Rides: 532'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

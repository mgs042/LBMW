import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng _selectedLocation = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    LocationData? currentLocation;

    var location = Location();

    try {
      await location.requestPermission();
      currentLocation = await location.getLocation();
    } catch (e) {
      print('Error getting user location: $e');
    }

    if (currentLocation != null) {
      setState(() {
        _selectedLocation = LatLng(
          currentLocation!.latitude!,
          currentLocation.longitude!,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _selectedLocation,
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        onTap: (LatLng location) {
          setState(() {
            _selectedLocation = location;
          });
        },
        markers: {
          Marker(
            markerId: MarkerId('selectedLocation'),
            position: _selectedLocation,
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Process the selected location
          if (_selectedLocation.latitude != 0 &&
              _selectedLocation.longitude != 0) {
            // Perform any desired actions with the selected location
            print('Selected location: $_selectedLocation');

            // Close the map screen and return the selected location
            Navigator.pop(context, _selectedLocation);
          }
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.check),
      ),
    );
  }
}

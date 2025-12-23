import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:placerr/models/place.dart';
import 'package:placerr/screens/map.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onHandleLocation});

  final void Function(PlaceLocation location) onHandleLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  bool? _isGettingLocation;
  PlaceLocation? _placeLocation;

  String get _locationImage {
    if (_placeLocation == null) return '';

    return 'https://maps.googleapis.com/maps/api/staticmap?center=${_placeLocation!.latitude},${_placeLocation!.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${_placeLocation!.latitude},${_placeLocation!.longitude}&key=AIzaSyDIXvyW6cAUi4HSpzab3nCrL5ELRFpsl7o';
  }

  Future _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) return;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDIXvyW6cAUi4HSpzab3nCrL5ELRFpsl7o',
    );
    final response = await http.get(url);
    final data = json.decode(response.body);
    final address = data['results'][0]['formatted_address'];

    setState(() {
      _isGettingLocation = false;
      _placeLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
    });

    if (_placeLocation == null) return;

    widget.onHandleLocation(_placeLocation!);
  }

  void pickLocation(PlaceLocation location) {
    widget.onHandleLocation(location);
    setState(() {
      _placeLocation = location;
    });
  }

  void _goToMap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapScreen(onHandleLocation: pickLocation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'No location!',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );

    if (_placeLocation != null) {
      content = Image.network(
        _locationImage,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      );
    }

    if (_isGettingLocation == true) {
      content = CircularProgressIndicator();
    }

    return Column(
      spacing: 12,
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          child: content,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getLocation,
              icon: Icon(Icons.location_on),
              label: Text('Get current location'),
            ),
            TextButton.icon(
              onPressed: _goToMap,
              icon: Icon(Icons.map),
              label: Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}

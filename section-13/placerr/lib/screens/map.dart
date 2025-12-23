import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placerr/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 45.657479,
      longitude: 25.601198,
      address: '',
    ),
    this.isSelecting = true,
    this.onHandleLocation,
  });

  final PlaceLocation location;
  final bool isSelecting;
  final void Function(PlaceLocation location)? onHandleLocation;

  @override
  State<MapScreen> createState() {
    return _MapScreen();
  }
}

class _MapScreen extends State<MapScreen> {
  LatLng? _location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick your location' : 'Your location',
        ),
        actions: [
          if (widget.isSelecting && widget.onHandleLocation != null)
            IconButton(
              onPressed: () {
                widget.onHandleLocation!(widget.location);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: (argument) => setState(() => _location = argument),
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers: (_location == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position:
                      _location ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}

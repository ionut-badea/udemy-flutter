import 'package:flutter/material.dart';
import 'package:placerr/models/place.dart';
import 'package:placerr/screens/map.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});

  final Place place;

  String get _locationImage {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${place.location.latitude},${place.location.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${place.location.latitude},${place.location.longitude}&key=AIzaSyDIXvyW6cAUi4HSpzab3nCrL5ELRFpsl7o';
  }

  void _goToMap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MapScreen(location: place.location, isSelecting: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _goToMap(context),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(_locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black12, Colors.black87],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

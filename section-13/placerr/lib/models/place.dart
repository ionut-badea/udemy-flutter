import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place({
    String? id,
    required this.title,
    required this.image,
    required this.location,
  }) : id = id ?? uuid.v4();

  String id;
  String title;
  File image;
  PlaceLocation location;
}

import 'dart:io';

import 'package:placerr/models/place.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart' as paths;
import "package:path/path.dart" as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

part 'places.g.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  return await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE places (id TEXT PRIMARY KEy, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)',
      );
    },
    version: 1,
  );
}

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => const [];

  Future<void> load() async {
    final db = await _getDatabase();
    final data = await db.query('places');
    state = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              latitude: row['latitude'] as double,
              longitude: row['longitude'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();
  }

  Future<void> add(Place place) async {
    final appDir = await paths.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.image.path);
    final storedImage = await place.image.copy('${appDir.path}/$fileName');
    final Place newPlace = Place(
      title: place.title,
      image: storedImage,
      location: place.location,
    );
    final db = await _getDatabase();

    db.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': newPlace.location.latitude,
      'longitude': newPlace.location.longitude,
      'address': newPlace.location.address,
    });

    state = [...state, newPlace];
  }

  void remove(Place place) async {
    final db = await _getDatabase();
    db.delete('places', where: 'id = ?', whereArgs: [place.id]);

    state = state.where((p) => p != place).toList();
  }
}

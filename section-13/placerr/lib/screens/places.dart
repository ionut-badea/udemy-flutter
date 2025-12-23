import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:placerr/providers/places.dart';
import 'package:placerr/screens/add_place.dart';
import 'package:placerr/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreen();
  }
}

class _PlacesScreen extends ConsumerState<PlacesScreen> {
  late Future<void> _places;

  @override
  void initState() {
    super.initState();
    _places = ref.read(placesProvider.notifier).load();
  }

  void _goToAddPlace(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddPlaceScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);
    final notifier = ref.watch(placesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            onPressed: () => _goToAddPlace(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _places,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return PlacesList(places: places, remove: notifier.remove);
        },
      ),
    );
  }
}

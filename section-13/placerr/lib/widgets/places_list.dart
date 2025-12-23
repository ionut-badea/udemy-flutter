import 'package:flutter/material.dart';
import 'package:placerr/models/place.dart';
import 'package:placerr/screens/place_details.dart';
import 'package:placerr/widgets/place_item.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places, required this.remove});

  final List<Place> places;
  final void Function(Place place) remove;

  void goToPlaceDetails(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PlaceDetailsScreen(place: place)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];

        return Dismissible(
          key: Key(place.id),
          onDismissed: (direction) => remove(place),
          child: InkWell(
            onTap: () => goToPlaceDetails(context, place),
            child: PlaceItem(place: place),
          ),
        );
      },
    );
  }
}

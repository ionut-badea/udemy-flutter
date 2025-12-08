import 'package:flutter/material.dart';
import 'package:mealy/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({
    super.key,
    required this.meal,
    required this.toggleMealFavoriteStatus,
  });

  final Meal meal;
  final void Function(Meal meal) toggleMealFavoriteStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () => toggleMealFavoriteStatus(meal),
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 12,
                children: [
                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    spacing: 2,
                    children: [
                      for (final ingredient in meal.ingredients)
                        Text(
                          ingredient,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                    ],
                  ),
                  Text(
                    'Steps',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    spacing: 2,
                    children: [
                      for (final ingredient in meal.steps)
                        Text(
                          ingredient,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

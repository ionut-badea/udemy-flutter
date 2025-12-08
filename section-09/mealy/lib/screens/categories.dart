import 'package:flutter/material.dart';
import 'package:mealy/data/dummy_data.dart';
import 'package:mealy/models/category.dart';
import 'package:mealy/models/meal.dart';
import 'package:mealy/screens/meals.dart';
import 'package:mealy/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.toggleMealFavoriteStatus,
    required this.meals,
  });

  final void Function(Meal meal) toggleMealFavoriteStatus;
  final List<Meal> meals;

  void _selectCategory(BuildContext context, Category category) {
    final mealsByCategory = meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MealsScreen(
          title: category.title,
          meals: mealsByCategory,
          toggleMealFavoriteStatus: toggleMealFavoriteStatus,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () => _selectCategory(context, category),
          ),
      ],
    );
  }
}

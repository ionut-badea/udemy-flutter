import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealy/models/meal.dart';

class FavoriteMeals extends Notifier<List<Meal>> {
  @override
  List<Meal> build() {
    return [];
  }

  bool toggleFavoriteStatus(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider = NotifierProvider<FavoriteMeals, List<Meal>>(
  FavoriteMeals.new,
);

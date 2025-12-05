import 'package:flutter/material.dart';
import 'package:mealy/data/dummy_data.dart';
import 'package:mealy/models/meal.dart';
import 'package:mealy/screens/categories.dart';
import 'package:mealy/screens/filters.dart';
import 'package:mealy/screens/meals.dart';
import 'package:mealy/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int currentIndex = 0;
  final List<Meal> favoriteMeals = [];
  Map<Filter, bool> _filters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    if (favoriteMeals.contains(meal)) {
      setState(() => favoriteMeals.remove(meal));
      _showInfoMessage('Meal was removed from favorites');
    } else {
      setState(() => favoriteMeals.add(meal));
      _showInfoMessage('Meal was added to favorites');
    }
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final filters = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(filters: _filters),
        ),
      );
      setState(() {
        _filters = filters ?? kInitialFilters;
      });
    }
  }

  void _selectTab(int value) => setState(() => currentIndex = value);

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget currentTab = CategoriesScreen(
      toggleMealFavoriteStatus: _toggleMealFavoriteStatus,
      meals: availableMeals,
    );
    String currentTitle = 'Categories';

    if (currentIndex == 1) {
      currentTab = MealsScreen(
        meals: favoriteMeals,
        toggleMealFavoriteStatus: _toggleMealFavoriteStatus,
      );
      currentTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(currentTitle)),
      drawer: MainDrawer(onSelectScreen: _selectScreen),
      body: currentTab,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}

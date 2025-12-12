import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealy/providers/favorites_provider.dart';
import 'package:mealy/providers/filters_provider.dart';
import 'package:mealy/providers/meals_provider.dart';
import 'package:mealy/screens/categories.dart';
import 'package:mealy/screens/filters.dart';
import 'package:mealy/screens/meals.dart';
import 'package:mealy/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int currentIndex = 0;

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (context) => FiltersScreen()),
      );
    }
  }

  void _selectTab(int value) => setState(() => currentIndex = value);

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget currentTab = CategoriesScreen(meals: availableMeals);
    String currentTitle = 'Categories';

    if (currentIndex == 1) {
      currentTab = MealsScreen(meals: ref.watch(favoriteMealsProvider));
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

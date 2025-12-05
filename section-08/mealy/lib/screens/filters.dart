import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.filters});

  final Map<Filter, bool> filters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.filters[Filter.glutenFree]!;
    _isLactoseFree = widget.filters[Filter.lactoseFree]!;
    _isVegetarian = widget.filters[Filter.vegetarian]!;
    _isVegan = widget.filters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filters')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFree,
            Filter.lactoseFree: _isLactoseFree,
            Filter.vegetarian: _isVegetarian,
            Filter.vegan: _isVegan,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _isGlutenFree,
              onChanged: (isChecked) =>
                  setState(() => _isGlutenFree = isChecked),
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only includes gluten-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SwitchListTile(
              value: _isLactoseFree,
              onChanged: (isChecked) =>
                  setState(() => _isLactoseFree = isChecked),
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only includes lactose-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SwitchListTile(
              value: _isVegetarian,
              onChanged: (isChecked) =>
                  setState(() => _isVegetarian = isChecked),
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only includes vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SwitchListTile(
              value: _isVegan,
              onChanged: (isChecked) => setState(() => _isVegan = isChecked),
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only includes vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

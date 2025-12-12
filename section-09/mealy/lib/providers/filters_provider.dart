import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class FilterNotifier extends Notifier<Map<Filter, bool>> {
  @override
  build() {
    return kInitialFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filterProvider = NotifierProvider<FilterNotifier, Map<Filter, bool>>(
  FilterNotifier.new,
);

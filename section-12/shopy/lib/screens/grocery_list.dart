import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopy/data/categories.dart';
import 'package:shopy/models/category.dart';
import 'package:shopy/models/grocery_item.dart';
import 'package:shopy/screens/add_item.dart';
import 'package:shopy/widgets/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  late Future<List<GroceryItem>> _items;

  @override
  void initState() {
    super.initState();
    _items = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    try {
      final url = Uri.https(
        'udemy-flutter-shopy-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json',
      );
      final List<GroceryItem> items = [];
      final response = await http.get(url);

      if (response.body == 'null') return [];

      final Map<String, dynamic> data = json.decode(response.body);

      for (final item in data.entries) {
        final category = categories.entries
            .firstWhere(
              (category) => category.value.name == item.value['category'],
            )
            .value;
        items.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: Category(category.name, category.color),
          ),
        );
      }

      return items;
    } catch (error) {
      throw Exception('Something went wrong');
    }
  }

  void _addItem() async {
    await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (context) => AddItem()));
  }

  void _removeItem(GroceryItem item) async {
    final url = Uri.https(
      'udemy-flutter-shopy-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping-list/${item.id}.json',
    );
    await http.delete(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your groceries'),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      // FutureBuilder works only for non changeable data.
      // To be able to see an updated list of items, the app should be reset.
      body: FutureBuilder(
        future: _items,
        builder: (content, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No grocery items'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) =>
                Item(item: snapshot.data![index], removeItem: _removeItem),
          );
        },
      ),
    );
  }
}

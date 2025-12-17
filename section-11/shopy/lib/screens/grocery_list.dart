import 'package:flutter/material.dart';
import 'package:shopy/models/grocery_item.dart';
import 'package:shopy/screens/add_item.dart';
import 'package:shopy/widgets/grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final groceryItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (context) => AddItem()));

    if (groceryItem == null) return;

    setState(() {
      _groceryItems.add(groceryItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No grocery items'));

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) =>
            Item(item: _groceryItems[index], removeItem: _removeItem),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your groceries'),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      body: content,
    );
  }
}

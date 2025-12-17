import 'package:flutter/material.dart';
import 'package:shopy/models/grocery_item.dart';

class Item extends StatelessWidget {
  const Item({super.key, required this.item, required this.removeItem});

  final GroceryItem item;
  final void Function(GroceryItem item) removeItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      onDismissed: (direction) {
        removeItem(item);
      },
      child: ListTile(
        leading: Container(width: 24, height: 24, color: item.category.color),
        title: Text(item.name),
        trailing: Text(item.quantity.toString()),
      ),
    );
  }
}

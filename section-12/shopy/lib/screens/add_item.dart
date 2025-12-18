import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopy/data/categories.dart';
import 'package:shopy/models/category.dart';
import 'package:shopy/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() {
    return _AddItem();
  }
}

class _AddItem extends State<AddItem> {
  final _keyForm = GlobalKey<FormState>();

  String _name = '';
  int _quantity = 1;
  Category _category = categories[Categories.vegetables]!;
  bool _isSending = false;

  void _resetForm() {
    _keyForm.currentState!.reset();
  }

  void _saveItem() async {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      final url = Uri.https(
        'udemy-flutter-shopy-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json',
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _name,
          'quantity': _quantity,
          'category': _category.name,
        }),
      );

      _isSending = true;

      if (!mounted) return;

      final String id = json.decode(response.body)['name'];
      Navigator.of(context).pop(
        GroceryItem(
          id: id,
          name: _name,
          quantity: _quantity,
          category: _category,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a new item")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _keyForm,
          child: Column(
            spacing: 12,
            children: [
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(label: Text('Name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: false,
                      ),
                      decoration: InputDecoration(label: Text('Quantity')),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! < 1) {
                          return 'Must be a valid number.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _quantity = int.parse(value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      initialValue: _category,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              spacing: 8,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  color: category.value.color,
                                ),
                                Text(category.value.name),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        _category = value!;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending ? null : _resetForm,
                    child: Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

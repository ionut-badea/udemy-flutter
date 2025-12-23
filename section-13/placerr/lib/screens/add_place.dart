import 'package:flutter/material.dart';
import 'package:placerr/widgets/add_place_form.dart';

class AddPlaceScreen extends StatelessWidget {
  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add place')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AddPlaceForm(),
      ),
    );
  }
}

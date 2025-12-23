import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:placerr/models/place.dart';
import 'package:placerr/providers/places.dart';
import 'package:placerr/widgets/image_input.dart';
import 'package:placerr/widgets/location_input.dart';

class AddPlaceForm extends HookConsumerWidget {
  const AddPlaceForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final image = useState<File?>(null);
    final location = useState<PlaceLocation?>(null);
    final form = useMemoized(() => GlobalKey<FormState>());

    final places = ref.watch(placesProvider.notifier);

    void submit() {
      form.currentState!.save();

      if (form.currentState!.validate() &&
          image.value != null &&
          location.value != null) {
        Navigator.of(context).pop();
        places.add(
          Place(
            title: titleController.text,
            image: image.value!,
            location: location.value!,
          ),
        );
      }
    }

    return SingleChildScrollView(
      child: Form(
        key: form,
        child: Column(
          spacing: 24,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(label: Text('Title')),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Title is mandatory';
                }
                return null;
              },
            ),
            ImageInput(onPickImage: (source) => image.value = source),
            LocationInput(
              onHandleLocation: (source) => location.value = source,
            ),
            SizedBox(height: 12),
            ElevatedButton(onPressed: submit, child: Text('Add place')),
          ],
        ),
      ),
    );
  }
}

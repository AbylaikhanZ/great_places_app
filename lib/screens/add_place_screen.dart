import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/providers/places_prov.dart';
import 'package:great_places_app/widgets/image_input.dart';
import 'package:great_places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  var _pickedImage = File('assets/images/placeHolder.jpeg');
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty) {
      return;
    }
    Provider.of<PlacesProv>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageInput(_selectImage),
                const SizedBox(
                  height: 10,
                ),
                LocationInput(_selectPlace),
              ],
            ),
          ))),
          ElevatedButton.icon(
              onPressed: _savePlace,
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: Theme.of(context).colorScheme.onSecondary),
              icon: const Icon(Icons.add),
              label: const Text('Add a Place')),
        ],
      ),
    );
  }
}

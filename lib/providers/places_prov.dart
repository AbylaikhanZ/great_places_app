import 'package:flutter/material.dart';
import 'dart:io';

import 'package:great_places_app/models/place.dart';

class PlacesProv with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: PlaceLocation(latitude: 0, longitude: 0));
    _items.add(newPlace);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:great_places_app/models/place.dart';

class PlacesProv with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
  
}

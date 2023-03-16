import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'dart:io';

import 'package:great_places_app/models/place.dart';

class PlacesProv with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: PlaceLocation(
            latitude: pickedLocation.latitude,
            longitude: pickedLocation.longitude,
            address: address));
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((e) => Place(
            id: e['id'],
            image: File(e['image']),
            location: PlaceLocation(
                latitude: e['loc_lat'],
                longitude: e['loc_lng'],
                address: e['address']),
            title: e['title']))
        .toList();
    notifyListeners();
  }
}

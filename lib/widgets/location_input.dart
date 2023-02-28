import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageURL = "No location chosen";
  static double? userLongitude;
  static double? userLatitude;

  Future<void> _getCurrentLocation() async {
    final userLocation = await Location().getLocation();
    final staticMapImage = LocationHelper.generateLocationPreview(
        latitude: userLocation.latitude, longitude: userLocation.longitude);
    setState(() {
      _previewImageURL = staticMapImage;
      userLatitude = userLocation.latitude;
      userLongitude = userLocation.longitude;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: ((ctx) => MapScreen(
              isSelecting: true,
            ))));
    if (selectedLocation == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: _previewImageURL == "No location chosen"
                ? const Text(
                    "No Location Chosen",
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _previewImageURL,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () => _getCurrentLocation(),
                icon: const Icon(Icons.location_on),
                label: const Text("Current location")),
            TextButton.icon(
                onPressed: () => _selectOnMap(),
                icon: const Icon(Icons.map),
                label: const Text("Select on map"))
          ],
        )
      ],
    );
  }
}

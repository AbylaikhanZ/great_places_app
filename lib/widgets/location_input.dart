import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  const LocationInput(this.onSelectPlace);
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageURL = "No location chosen";

  void setPreviewImage(double? lat, double? lng) {
    final staticMapImage =
        LocationHelper.generateLocationPreview(latitude: lat, longitude: lng);
    setState(() {
      _previewImageURL = staticMapImage;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final userLocation = await Location().getLocation();
      setPreviewImage(userLocation.latitude, userLocation.longitude);
      widget.onSelectPlace(userLocation.latitude, userLocation.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: ((ctx) => MapScreen(
                  isSelecting: true,
                ))));
    setPreviewImage(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
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

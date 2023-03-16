import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/widgets/location_input.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.442, longitude: -122.084),
      this.isSelecting = false});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _pickedLoc = LatLng(0.0, 0.0);
  void selectLoc(LatLng loc) {
    setState(() {
      _pickedLoc = loc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select the location"), actions: [
        if (widget.isSelecting)
          IconButton(
              onPressed: _pickedLoc.latitude == 0.0 && _pickedLoc.longitude == 0
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLoc);
                    },
              icon: const Icon(Icons.check))
      ]),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 20,
        ),
        onTap: widget.isSelecting ? selectLoc : null,
        markers: _pickedLoc.latitude == 0.0 &&
                _pickedLoc.longitude == 0.0 &&
                widget.isSelecting
            ? {}
            : {
                Marker(
                    markerId: const MarkerId('m1'),
                    position: (_pickedLoc.latitude == 0.0 &&
                            _pickedLoc.longitude == 0.0)
                        ? LatLng(widget.initialLocation.latitude,
                            widget.initialLocation.longitude)
                        : _pickedLoc),
              },
      ),
    );
  }
}

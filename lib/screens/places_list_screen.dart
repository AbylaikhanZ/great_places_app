import 'package:flutter/material.dart';
import 'package:great_places_app/providers/places_prov.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Consumer<PlacesProv>(
        child: const Center(child: Text("No places yet. Start adding some!")),
        builder: (ctx, places, ch) => places.items.isEmpty
            ? ch!
            : ListView.builder(
                itemCount: places.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  title: Text(places.items[i].title),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(places.items[i].image),
                  ),
                  onTap: () {},
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:great_places_app/providers/places_prov.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlacesProv(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.lime,
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Colors.indigo,
                onPrimary: Colors.white,
                secondary: Colors.amber,
                onSecondary: Colors.black,
                error: Colors.red,
                onError: Colors.white,
                background: Colors.white,
                onBackground: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black)),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
        },
      ),
    );
  }
}

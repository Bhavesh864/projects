import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/add_places_screen.dart';
import './providers/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/place_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          secondaryHeaderColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlacesScreen.routeName: (context) => AddPlacesScreen(),
          PlaceDetailsScreen.routeName: (context) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}

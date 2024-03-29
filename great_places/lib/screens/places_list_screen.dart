import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_places_screen.dart';
import '../providers/great_places.dart';
import './place_details_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetData(),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(child: const Text('Got no places yet! Start adding some.')),
                builder: (ctx, greatPlaces, child) => greatPlaces.items.length <= 0
                    ? child!
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (context, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(greatPlaces.items[i].image),
                          ),
                          title: Text(greatPlaces.items[i].title),
                          subtitle: Text(greatPlaces.items[i].location!.address.toString()),
                          onTap: () {
                            // Navigator.of(context).pushNamed(PlaceDetailsScreen.routeName, arguments: greatPlaces.items[i].id);
                            Navigator.pushNamed(context, PlaceDetailsScreen.routeName, arguments: greatPlaces.items[i].id);
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}

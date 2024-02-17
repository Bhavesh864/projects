import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/helpers/location_helper.dart';

import '../models/places.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(Object? id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(String pickedTitle, File? pickedImage, PlaceLocation? _pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
      _pickedLocation!.latitude,
      _pickedLocation.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: _pickedLocation.latitude,
      longitude: _pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage!,
      location: updatedLocation,
    );

    _items.add(newPlace);
    notifyListeners();
    DbHelper.insertData('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address.toString(),
    });
  }

  Future<void> fetchAndSetData() async {
    final dataList = await DbHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}

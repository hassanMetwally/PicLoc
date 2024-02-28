import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_device_features/helpers/LocationHelper.dart';
import 'package:native_device_features/helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

   addPlace(String title, File? pickedImage, PlaceLocation? pickedLocation)  async{
     //print('0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
     String placeName = await LocationHelper.getPlaceName(pickedLocation!.latitude,pickedLocation.longitude);
    // print('122222222222222222222222222222222222222222222222222222222222222222');
     PlaceLocation updatedLocation = PlaceLocation(latitude: pickedLocation.latitude, longitude: pickedLocation.longitude,address: placeName);
     Place newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: pickedImage,
      location: updatedLocation,
    );

    _items.add(newPlace);

    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image!.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'loc_address': newPlace.location!.address!,
    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(latitude: item['loc_lat'],longitude: item['loc_lng'],address: item['loc_address'])))
        .toList();
    notifyListeners();
  }
}

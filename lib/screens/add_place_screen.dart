// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:native_device_features/models/place.dart';
import 'package:native_device_features/widgets/location_input.dart';
import 'package:provider/provider.dart';
import '../providers/greet_places.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  _selectLocation(double lat, double lng) {
    // String placeName = await LocationHelper.getPlaceName(lat, lng);
    _pickedLocation = PlaceLocation(
      latitude: lat, longitude: lng,
      //address: placeName,
    );
  }

  _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      // Scaffold.of(context).showSnackBar(SnackBar(
      //     content: Text('Add picture, location and title to save the place')));
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a New Place')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(label: Text('Title')),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectLocation)
                  ],
                ),
              ),
              scrollDirection: Axis.vertical,
            ),
          ),
          TextButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add place'),
            onPressed: _savePlace,
           style: TextButton.styleFrom(
             elevation: 0,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
             backgroundColor: Theme.of(context).accentColor,
           ),
           // elevation: 0,
           // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
           // color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}

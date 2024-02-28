// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/greet_places.dart';
import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.routName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
        builder: (context, snapShot) => snapShot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (context, greatPlaces, ch) =>
                greatPlaces.items.isEmpty
                    ? ch ?? Text('')
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.items[i].image!),
                            ),
                            title: Text(greatPlaces.items[i].title),
                            subtitle: Text(
                                greatPlaces.items[i].location!.address!),
                            onTap: () {
                              ///Go to details screen...
                            },
                          );
                        }),
                child: Center(
                  child: Text('Got no places yet, start adding some'),
                ),
              ),
      ),
    );
  }
}

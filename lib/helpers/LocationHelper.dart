import 'dart:convert';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;


const String GOOGLE_API_KEY ='AIzaSyClH4VsCb92uMzMSjZoQ7UxD3S4423taCs';

class LocationHelper{
  static String generateLocationPreviewImage({required double? latitude,required double? longitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&${latitude!},${longitude!}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
  
  // static Future<PlaceLocation> getCurrentLocation() async{
  //   final locData =  await Location().getLocation();
  //   PlaceLocation currentLocation = PlaceLocation(latitude: locData.latitude!, longitude: locData.longitude!);
  //   return currentLocation;
  // }

  static Future<String> getPlaceName(double lat, double lng)async{
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print('${json.decode(response.body)} 1111111111111111111');
    print('${json.decode(response.body)['results'][0]['formatted_address']} 2222222222222222222');
    return json.decode(response.body)['results'][0]['formatted_address'];

  }
}
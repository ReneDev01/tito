import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/place.dart';
import '../models/place_search.dart';

class PlaceController{

  //declare key variable
  final key = "AIzaSyC9AWx_hS2Ly4fF6PQOEMM6mlcevpMSYDE";
  final lang = "pt_FR";
  Future<List<PlaceSearch>> getAutocomplete(String search) async{
    var url = 
    'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&language=$lang&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json["predictions"] as List;

    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

//get place
  Future<Place> getPlace(String place_id) async{
    var url = 
    'https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$place_id';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json["result"] as Map<String, dynamic>;

    return Place.fromJson(jsonResult);
  }

  //store place
  Future<List<Place>> getPlaces(double lat, double lng, String placeType) async{
    var url = 
    'https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=$placeType&location=$lat,$lng&rankby=distance&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json["results"] as List;

    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
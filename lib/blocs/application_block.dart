import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tito/controllers/geolocator_service.dart';
import 'package:tito/controllers/place_controller.dart';
import 'package:tito/models/geometry.dart';
import 'package:tito/models/location.dart';
import 'package:tito/models/place_search.dart';

import '../controllers/marker_controller.dart';
import '../models/place.dart';

class ApplicationBloc with ChangeNotifier
{
  final geoLocatorService = GeolocatorService();
  final placeController = PlaceController();
  final markerController = MarkerController();

  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();

  //variables
  //(Position variable for current location)
  late Position currentLocation;
  //List of place search
  late List<PlaceSearch> searchResults;
  late List<Marker> markers = <Marker>[];
  Place selectedLocationStatic = Place();
  

  String placeType = "";

  StreamController<Place> selectedLocation = StreamController<Place>();

  ApplicationBloc()
  {
    setCurrentLocation();
    searchResults = [];
  }

  //fonction to get current location
  setCurrentLocation() async{
    //we call geolocation service to get current loocation
    currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Place(
      name: null, 
      geometry: Geometry(
        location: Location(
          lat: currentLocation.latitude, 
          lng: currentLocation.longitude
        )
      )
    );
    //print(currentLocation);
    notifyListeners();
  }

  //search location places
  searchPlace(String searchTerm) async{
    searchResults = await placeController.getAutocomplete(searchTerm);
    //print(searchResults);
    notifyListeners();
  }

  //get location search place id
  setSelecetedLocation(String place_id) async{
    var sLocation = await placeController.getPlace(place_id);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = [];
    notifyListeners();
  }

  //togglePlaceType
  togglePlaceType(String value, bool selected)async{
    if(selected){
      placeType = value;
    }else{
      placeType = "";
    }

    if(placeType != null){
      var places = await placeController.getPlaces(
        selectedLocationStatic.geometry!.location.lat!, 
        selectedLocationStatic.geometry!.location.lng!, 
        placeType
      );

      markers = [];
      if(places.length > 0)
      {
        var newMarker = markerController.createMarkerFromPlace(places[0]);
        markers.add(newMarker);
      }

      var locationMarker = markerController.createMarkerFromPlace(selectedLocationStatic);
      markers.add(locationMarker);

      var _bounds = markerController.bounds(Set<Marker>.of(markers));
      bounds.add(_bounds!);
    }

    notifyListeners();
  }

  //select place
  @override
  void dispose(){
    selectedLocation.close();
    super.dispose();
  }
}
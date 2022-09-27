import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MarkerController{

  LatLngBounds? bounds(Set<Marker> markers){
    if(markers == null || markers.isEmpty){
      return null;
    }
    return createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds createBounds(List<LatLng> positions)
  {
    final southwestLat = positions.map((p) => p.latitude).reduce((value, element) => value < element ? value : element);
    final southwestLng = positions.map((p) => p.longitude).reduce((value, element) => value < element ? value : element);
    final northwestLat = positions.map((p) => p.latitude).reduce((value, element) => value > element ? value : element);
    final northwestLng = positions.map((p) => p.longitude).reduce((value, element) => value > element ? value : element);

    return LatLngBounds(
      southwest: LatLng(southwestLat, southwestLng),
      northeast: LatLng(northwestLat, northwestLng)
    );
  }


  Marker createMarkerFromPlace(Place place){
    final markerId = place.name;
    return Marker(
      markerId: MarkerId(markerId!),
      draggable: false,
      infoWindow: InfoWindow(
        title: place.name, snippet: place.vicinity,
      ),
      position: LatLng(place.geometry!.location.lat!, place.geometry!.location.lng!)
    );
  }
}
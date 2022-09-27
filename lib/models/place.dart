import 'package:tito/models/geometry.dart';

class Place{
  final Geometry? geometry;
  final name;
  final vicinity;

  Place({
     this.geometry, this.name, this.vicinity
  });

  factory Place.fromJson(Map<String, dynamic> parsedJson){
    return Place(
      geometry: Geometry.fromJson(parsedJson['geometry']),
      name: parsedJson['formatted_address'],
      vicinity: parsedJson['vicinity']
    );
  }
}
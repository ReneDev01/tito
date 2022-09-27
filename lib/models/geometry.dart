import 'package:tito/models/location.dart';

class Geometry{
  final Location location;

  Geometry({required this.location});
  
  factory Geometry.fromJson(Map<String, dynamic> parsedJson){
    return Geometry(
      location: Location.fromJson(parsedJson['location'])
    );
  }
}
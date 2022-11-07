import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:tito/components/constante.dart';
import 'package:tito/views/courses/StartCourse.dart';
import 'package:tito/views/courses/course_information.dart';
import 'package:tito/views/compte/place/place.dart';
import 'package:tito/views/courses/course_start_adress.dart';
import 'package:tito/views/courses/resumer.dart';

import '../../controllers/locale_store.dart';
import 'package:localstorage/localstorage.dart';

import '../../controllers/strict_local_storage.dart';

class AdressDestination extends StatefulWidget {
  const AdressDestination({Key? key}) : super(key: key);

  @override
  State<AdressDestination> createState() => _AdressDestination();
}

const kGoogleApiKey = 'AIzaSyC9AWx_hS2Ly4fF6PQOEMM6mlcevpMSYDE';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _AdressDestination extends State<AdressDestination> {
  
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(6.196146, 1.200136), zoom: 14.0);

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;

  double lati = 0;
  double long = 0;

  double tapLat = 0;
  double tapLng = 0;
  int strId = 0;

  Position position = Position(
      longitude: 1.200136,
      latitude: 6.196146,
      timestamp: DateTime.now(),
      accuracy: 2,
      altitude: 2,
      heading: 2,
      speed: 2,
      speedAccuracy: 2);

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'fr',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: appBlackColor))),
        components: [Component(Component.country, "tg")]);
    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    tapLat = 0;
    tapLng = 0;

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    lati = lat;
    long = lng;

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }

  Future<void> mapTap(latlng) async {
    markersList.remove(Marker(
      markerId: const MarkerId("0"),
      position: latlng,
    ));
    markersList.add(Marker(
      markerId: const MarkerId("0"),
      position: latlng,
    ));
    tapLat = latlng.latitude;
    tapLng = latlng.longitude;
    setState(() {});
    print(tapLat);
    print(tapLng);
  }

  Future<void> GetAdressFromLatLong(Position position) async {
    /* List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark); */
    markersList.clear();
    markersList.add(Marker(
      markerId: const MarkerId("0"),
      position: LatLng(position.latitude, position.longitude),
    ));
    setState(() {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> showInformationDialog(BuildContext context, String title) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            elevation: 3,
            title: Text(
              "${title}",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: appBlackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CourseAdress()),
                            (route) => false);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Non",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: blue2,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      /* Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Place()),
                          (route) => false); */
                      tapLat != 0 && tapLng != 0
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Place(
                                      latitude: tapLat, longitude: tapLng)),
                            )
                          : Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Place(latitude: lati, longitude: long)),
                            );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Text(
                        "Oui",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: blue2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
            backgroundColor: appBackground,
          );
        });
  }

  Future<void> getPosition() async {
    Position position = await _determinePosition();
    GetAdressFromLatLong(position);
  }

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      //backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBlackColor,
        title: Text(
          "Tito Togo",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: appBackground,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markersList,
            mapType: MapType.normal,
            onTap: mapTap,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: appBlackColor),
                    onPressed: _handlePressButton,
                    child: const Text("Rechercher"),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: appColor),
                      onPressed: () async {
                        //Position position = await _determinePosition();
                        if (tapLat != 0 && tapLng != 0) {
                          addItemsEndLatLng(tapLat, tapLng);
                        } else if (lati != 0 && long != 0) {
                          addItemsEndLatLng(lati, long);
                        } else {
                          addItemsEndLatLng(
                              position.latitude, position.longitude);
                        }
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CourseAdress()),
                            (route) => false);
                      },
                      child: const Text("Suivant")),
                ]),
          )
        ],
      ),
    );
  }
}

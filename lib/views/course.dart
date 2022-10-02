import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:tito/components/constante.dart';
import 'package:tito/views/course_information.dart';

class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

const kGoogleApiKey = 'AIzaSyC9AWx_hS2Ly4fF6PQOEMM6mlcevpMSYDE';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _CourseState extends State<Course> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(6.196146, 1.200136), zoom: 14.0);

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;

  double lati = 0;
  double long = 0;

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
    //setState(() {});
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
                    child: const Text("Où allez-vous?"),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: appColor),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Detail(latitude:lati, longitude:long)),
                            );
                      },
                      child: const Text("Suivant")),
                ]),
          )
        ],
      ),
    );
  }
}

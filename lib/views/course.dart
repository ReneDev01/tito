import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:provider/provider.dart';
import 'package:tito/blocs/application_block.dart';

import '../components/constante.dart';
import '../models/place.dart';

class Course extends StatefulWidget {
  Course({Key? key}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

const kGoogleAPIKey = '5e7e4296198256f1538e6e88454cdcae';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _CourseState extends State<Course> {
  final _formKey = GlobalKey<FormState>();
  final current_place_Text = TextEditingController();
  final arrived_place_Text = TextEditingController();
  final current_latitude_Text = TextEditingController();
  final current_longitude_Text = TextEditingController();
  final current_address_Text = TextEditingController();
  Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;

  late StreamSubscription boundsSubscription;
  

  @override
  void initState(){
    final applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    locationSubscription = applicationBloc.selectedLocation.stream.listen((place) {
      if(place != null){
        _goToPlace(place);
      }
    });

    boundsSubscription = applicationBloc.bounds.stream.listen((bounds) async { 
      final GoogleMapController controller = await _mapController.future;

      controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 50.0)
      );
    });

    super.initState();
  }

  @override
  void dispose(){
    final applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    boundsSubscription.cancel();
    locationSubscription.cancel();
    super.dispose();
  }



  bool isVisible = false;

  List<DropdownMenuItem<String>> get placeItems {
    List<DropdownMenuItem<String>> infos = [
      DropdownMenuItem(
        child: Text("USA"),
        value: "USA",
      ),
      DropdownMenuItem(
        child: Text("Canada"),
        value: "Canada",
      ),
      DropdownMenuItem(
        child: Text("France"),
        value: "France",
      ),
    ];
    return infos;
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

  Future<void> GetAdressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
          backgroundColor: appBlackColor,
          title: Text(
            "Tito Togo",
            textAlign:TextAlign.center,
            style: GoogleFonts.poppins(
              color: appBackground,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
      ),
      body:(applicationBloc.currentLocation == null) 
      ? Center(
          child: CircularProgressIndicator(),
        )
      : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8, bottom:8),
                child: TextField(
                  style: GoogleFonts.poppins(
                    color: appBlackColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appBlackColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: appBlackColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Où allez-vous??",
                    hintStyle: GoogleFonts.poppins(
                      color: appBlackColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: Icon(Icons.search, color: appBlackColor),
                  ),
                  onChanged: (value) => applicationBloc.searchPlace(value),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 300,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      markers: Set<Marker>.of(applicationBloc.markers),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          applicationBloc.currentLocation.latitude, 
                          applicationBloc.currentLocation.longitude
                        ),
                        zoom: 14,
                      ),
                      onMapCreated: (GoogleMapController controller){
                        _mapController.complete(controller);
                      },
                    ),
                  ),
                  if(applicationBloc.searchResults != null && 
                  applicationBloc.searchResults.length != 0)
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.5),
                      backgroundBlendMode: BlendMode.darken
                    ),
                  ),
                  if(applicationBloc.searchResults != null && 
                  applicationBloc.searchResults.length != 0)
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: applicationBloc.searchResults.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(
                            applicationBloc.searchResults[index].description!,
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          onTap: (){
                            applicationBloc.setSelecetedLocation(
                              applicationBloc.searchResults[index].place_id!
                            );
                          },
                        );
                      } ,
                    ),
                  ) 
                ],
              ),
              /* SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: EdgeInsets.only(top:8, bottom: 8),
                child: Text(
                  "Trouver une place",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: appBlackColor,
                  ),
                ),
              ), */
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              /* Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Wrap(
                  spacing: 8.0,
                  children: [
                    FilterChip(
                      label:Text('Campground'),
                      onSelected: (val) => 
                      applicationBloc.togglePlaceType('campground', val),
                      selected: applicationBloc.placeType == 'campground',
                      selectedColor: appColor,
                    ),
                    FilterChip(
                      label:Text('ATM'),
                      onSelected: (val) => 
                      applicationBloc.togglePlaceType('atm', val),
                      selected: applicationBloc.placeType == 'atm',
                      selectedColor: appColor,
                    ),
                    FilterChip(
                      label:Text('phamarcy'),
                      onSelected: (val) => 
                      applicationBloc.togglePlaceType('phamarcy', val),
                      selected: applicationBloc.placeType == 'phamarcy',
                      selectedColor: appColor,
                    ),FilterChip(
                      label:Text('zoo'),
                      onSelected: (val) => 
                      applicationBloc.togglePlaceType('zoo', val),
                      selected: applicationBloc.placeType == 'zoo',
                      selectedColor: appColor,
                    )
                  ],
                ),
              ), */
/*               Container(
                height: MediaQuery.of(context).size.height * 0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: appColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text("Où allez-vous?  ",
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              color: appBackground,
                              fontWeight: FontWeight.w500)),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: appBackground,
                      size: 40,
                    )
                  ],
                ),
              ), */
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Commander votre moto ',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            letterSpacing: 1,
                          ),
                          children: [
                            TextSpan(
                              text: 'tit',
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: appColor,
                              ),
                            ),
                            TextSpan(
                              text: 'o',
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: appBlackColor,
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(),
                          Container(
                            child: Column(
                              children: [
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Lieux de départ",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: appBlackColor),
                                        ),
                                        SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height *
                                                    0.02),
                                        myInputTextFormField(
                                            appBlackColor,
                                            Colors.white12,
                                            appColor,
                                            "Où êtes-vous? (Ex: A côté de 2 lions)",
                                            current_place_Text, 'Actuel place',),
                                            
                                        SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height *
                                                    0.02),
                                        Visibility(
                                            visible: isVisible,
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  myInputTextFormField(
                                                      appBlackColor,
                                                      Colors.white12,
                                                      appColor,
                                                      "latitude",
                                                      current_latitude_Text, 'latitude',),
                                                  SizedBox(
                                                      height: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02),
                                                  myInputTextFormField(
                                                      appBlackColor,
                                                      Colors.white12,
                                                      appColor,
                                                      "longitude",
                                                      current_longitude_Text, 'longitude',),
                                                ],
                                              ),
                                            )
                                        ),
                                        SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height *
                                                    0.005),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: myFlatButton(
                                              appBlackColor,
                                              Colors.white,
                                              'Prendre ma position',
                                              appBlackColor, () async {
                                            Position position =
                                                await _determinePosition();

                                            print(position.longitude);
                                            print(position.latitude);
                                            /* location =
                                                'Lat : ${position.latitude}, Long:${position.longitude}'; */
                                            GetAdressFromLatLong(position);
                                            setState(() {});
                                          }),
                                        ),
                                        SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height *
                                                    0.005),
                                        Text(
                                          "- Ou -",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: appBlackColor),
                                        ),
                                        SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height *
                                                    0.005),
                                        myDropdownButton(
                                            appBlackColor,
                                            Colors.white12,
                                            appColor,
                                            "Cliquer pour selectioner un lieux",
                                            () {},
                                            placeItems),
                                        SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height *
                                                    0.02),
                                        Text(
                                          "Lieux d'arrivé",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: appBlackColor),
                                        ),
                                        SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height *
                                                    0.02),
                                        myInputTextFormField(
                                            appBlackColor,
                                            Colors.white12,
                                            appColor,
                                            "Où deplacez-vous? (Ex: Vers agbalépédo à coté de ....)",
                                            arrived_place_Text, 'Arrivée',),
                                      ],
                                    )
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToPlace(Place place) async{
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(place.geometry!.location.lat!, place.geometry!.location.lng!), 
        zoom: 14)
      )
    );
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import '../components/constante.dart';

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

  /* @override
  void initState() {
    // TODO: implement initState
    Position position = await _determinePosition();
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
          backgroundColor: appBlackColor,
          title: Text(
            "Demarer une course",
            textAlign:TextAlign.center,
            style: GoogleFonts.poppins(
              color: appBackground,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
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
              ),
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

}

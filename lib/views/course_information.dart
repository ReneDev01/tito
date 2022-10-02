import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/constante.dart';

class Detail extends StatefulWidget {
  double latitude;
  double longitude;
  Detail({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

const kGoogleAPIKey = '5e7e4296198256f1538e6e88454cdcae';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _DetailState extends State<Detail> {
  final _formKey = GlobalKey<FormState>();
  final destination_latitude_Text = TextEditingController();
  final destination_longitude_Text = TextEditingController();
  final destination_address_Text = TextEditingController();
  final current_latitude_Text = TextEditingController();
  final current_longitude_Text = TextEditingController();
  final current_address_Text = TextEditingController();
  @override
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

    Placemark place = placemark[0];

    //longi = ${place.}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      "${widget.latitude}",
                      style: GoogleFonts.poppins(color: appBlackColor),
                    ),
                    Text(
                      "${widget.longitude}",
                      style: GoogleFonts.poppins(color: appBlackColor),
                    ),
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
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        myInputTextFormField(
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "Décriver votre destination (Ex: A côté de 2 lions)",
                                          destination_address_Text,
                                          'Actuel place',
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
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
                                                    destination_latitude_Text,
                                                    'latitude',
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02),
                                                  myInputTextFormField(
                                                    appBlackColor,
                                                    Colors.white12,
                                                    appColor,
                                                    "longitude",
                                                    destination_longitude_Text,
                                                    'longitude',
                                                  ),
                                                ],
                                              ),
                                            )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        Text(
                                          'Où êtes-vous?',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: myFlatButton(
                                              appBlackColor,
                                              Colors.white,
                                              'Prendre ma position',
                                              appBlackColor, () async {
                                            Position position =
                                                await _determinePosition();

                                            print(position.longitude);
                                            print(position.latitude);
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
                                                        current_latitude_Text,
                                                        'latitude',
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02),
                                                      myInputTextFormField(
                                                        appBlackColor,
                                                        Colors.white12,
                                                        appColor,
                                                        "longitude",
                                                        current_longitude_Text,
                                                        'longitude',
                                                      ),
                                                    ],
                                                  ),
                                                ));

                                            current_longitude_Text.text =
                                                '${position.longitude}';
                                            current_latitude_Text.text =
                                                '${position.latitude}';
                                            /* location =
                                                'Lat : ${position.latitude}, Long:${position.longitude}'; */
                                            GetAdressFromLatLong(position);
                                            setState(() {});
                                          }),
                                        ),
                                        /* SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        myDropdownButton(
                                            appBlackColor,
                                            Colors.white12,
                                            appColor,
                                            "Cliquer pour selectioner un lieux",
                                            () {},
                                            placeItems), */
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        myInputTextFormField(
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "Où êtes-vous? (Ex:agbalépédo à coté de ....)",
                                          current_address_Text,
                                          'Arrivée',
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: myFlatButton(appBlackColor, Colors.white,
                                'Commander une course', appBlackColor, () {
                              destination_latitude_Text.text = widget.latitude.toString() ;
                              destination_longitude_Text.text = widget.longitude.toString();
                              print(current_latitude_Text.text);
                              print(current_longitude_Text.text);
                              print(destination_latitude_Text.text);
                              print(destination_longitude_Text.text);
                            }),
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

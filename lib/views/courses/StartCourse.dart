import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/views/courses/address_search.dart';
import 'package:tito/views/courses/adresse.dart';
import 'package:tito/views/courses/course.dart';
import 'package:tito/views/courses/neighborhood.dart';

import '../../components/constante.dart';

class StartCourse extends StatefulWidget {
  const StartCourse({super.key});

  @override
  State<StartCourse> createState() => _StartCourseState();
}

class _StartCourseState extends State<StartCourse> {
  double latitude = 0;
  double longitude = 0;
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

  getPosition() async {
    Position position = await _determinePosition();
    latitude = position.latitude;
    longitude = position.longitude;
    setState(() {});
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
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            actions: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: myFlatButton2(appBackground, appBlackColor,
                    'Choisir une adresse', appColor, () 
                    async {
                      Navigator.pop(context);
                      await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Address()));
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: myFlatButton2(
                    appColor, Colors.white, 'Nouvelle addresse', appColor,
                    () async {
                  getPosition();
                  Navigator.pop(context);
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Course(latitude: latitude, longitude: longitude)));
                }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => StartCourse()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    "Retour",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: blue2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
            backgroundColor: appBackground,
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    getPosition();
    super.initState();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Nos Services",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: appBlackColor,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showInformationDialog(context, "Course de Bus");
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 65,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/bus.jpg"),
                                      fit: BoxFit.contain)),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Bus",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: appBlackColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showInformationDialog(
                            context, "Course de moto tricycle");
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 65,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("images/taxi-moto2.jpg"),
                                      fit: BoxFit.contain)),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Tricycle",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: appBlackColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showInformationDialog(
                            context, "Course de taxi-voiture");
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 65,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/taxi.jpg"),
                                      fit: BoxFit.contain)),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Taxi",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: appBlackColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showInformationDialog(context, "Course de voiture climée");
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 65,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/voiture.jpg"),
                                      fit: BoxFit.contain)),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Climée",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: appBlackColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showInformationDialog(context, "Course de Voiture");
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 65,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("images/taxi.jpg"),
                                        fit: BoxFit.contain)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Personel",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: appBlackColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showInformationDialog(context, "Course de moto");
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 65,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("images/taxi-moto.jpg"),
                                        fit: BoxFit.contain)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Taxi-Moto",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: appBlackColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

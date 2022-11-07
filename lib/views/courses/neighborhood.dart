import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/views/courses/course_information.dart';
import 'package:tito/views/courses/destination.dart';
import 'package:tito/views/courses/neighborhood_search.dart';
import 'package:tito/views/courses/resumer.dart';
import 'package:tito/views/courses/second_destination.dart';

import '../../components/constante.dart';
import '../../controllers/adress_controller.dart';
import '../../controllers/client_controller.dart';
import '../../controllers/strict_adress_controller.dart';
import '../../controllers/strict_local_storage.dart';
import '../../models/api_response.dart';
import '../../models/district.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import 'course_map_neighbord.dart';

class Neighborhood extends StatefulWidget {
  const Neighborhood({super.key});

  @override
  State<Neighborhood> createState() => _NeighborhoodState();
}

class _NeighborhoodState extends State<Neighborhood> {
  List<District>? listDistrict = [];
  final nameText = TextEditingController();

  final LocalStorage storageAdress = LocalStorage('localstorage_app');

  Future<void> _getLitsDistrict() async {
    String token = await getToken();
    var result = await http.get(
      Uri.parse("http://145.239.198.239:8090/api/districts"),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    listDistrict = jsonDecode(result.body)
        .map((item) => District.fromJson(item))
        .toList()
        .cast<District>();
    setState(() {});
  }

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

  @override
  void initState() {
    // TODO: implement initState
    _getLitsDistrict();
    getPosition();
    super.initState();
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
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: myFlatButton2(appBackground, appBlackColor,
                    'Choisir une adresse', appColor, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Neighborhood()));
                }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: myFlatButton2(appBlackColor, Colors.white,
                    'Choisir un quartier', appBlackColor, () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const Neighborhood()),
                  );
                }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: myFlatButton2(
                    appColor, Colors.white, 'Nouvelle addresse', appColor, () {
                  getPosition();
                  /* Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NeighborhoodDestination())); */
                }),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBlackColor,
        title: const Text('Tito TOGO'),
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: NeighborhoodSearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              neighborhoodPlace(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                child: Text(
                  "-Fin-",
                  style: GoogleFonts.poppins(color: appBlackColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget neighborhoodPlace() {
    return listDistrict != null
        ? Container(
            margin: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: listDistrict!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int itemIndex) =>
                        GestureDetector(
                            onTap: () async {
                              ApiResponse response = await getStrictInfo(
                                  int.parse("${listDistrict![itemIndex].id}"));
                              setState(() {
                                var adress = response.data as Map;
                                print(adress['id']);
                                addItemsOrderAdress(
                                  adress['id'],
                                );
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MapNeighboord()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: appBlackColor, width: 3),
                                color: appBackground,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 15),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Text(
                                            "${listDistrict![itemIndex].name}",
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                                color: appBlackColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 15, bottom: 12),
                                    child: Icon(
                                      Icons.location_on_rounded,
                                      color: appColor,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            )))))
        : Container();
  }
}

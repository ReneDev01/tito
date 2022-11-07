import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/models/adress.dart';
import 'package:tito/views/courses/second_adress.dart';
import 'package:tito/views/courses/second_destination.dart';

import '../../components/constante.dart';
import '../../controllers/adress_controller.dart';
import '../../controllers/adress_local_storage.dart';
import '../../controllers/client_controller.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../../models/api_response.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  List<Adress>? adress = [];
  final nameText = TextEditingController();

  final LocalStorage storageAdress = LocalStorage('localstorage_app');

  Future<void> _getLitsDistrict() async {
    String token = await getToken();
    var result = await http.get(
      Uri.parse("http://145.239.198.239:8090/api/addresses"),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    adress = jsonDecode(result.body)
        .map((item) => Adress.fromJson(item))
        .toList()
        .cast<Adress>();
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
                      builder: (context) => const SecondAdress()));
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
                  /* Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const Neighborhood()),
                  ); */
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AdressDestination()));
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
        /* actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () {
                /* showSearch(context: context, delegate: NeighborhoodSearch()); */
              },
              icon: const Icon(Icons.search))
        ], */
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              adressList(),
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

  Widget adressList() {
    return adress != null
        ? Container(
            margin: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: adress!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int itemIndex) =>
                        GestureDetector(
                            onTap: () async {
                              ApiResponse response = await getAdressInfo(
                                  int.parse("${adress![itemIndex].id}"));
                              var address = response.data as Map;
                              print(address['id']);
                              addItemsAdressStore(address['id']);
                              showInformationDialog(
                                  context, "Adresse d'arrivé");
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
                                            "${adress![itemIndex].name}",
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                                color: appBlackColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
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

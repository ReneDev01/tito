import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../components/constante.dart';

class Place extends StatefulWidget {
  Place({Key? key}) : super(key: key);

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {

  final _formKey = GlobalKey<FormState>();
  final current_place_Text = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
          backgroundColor: appBlackColor,
          title: Text(
            "Enrégistrer une position",
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
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          myInputTextFormField(
                            appBlackColor,
                            Colors.white12,
                            appColor,
                            "Où êtes-vous? (Ex: A côté de 2 lions)",
                            current_place_Text, 'description',),
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
                        ],
                      )
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }

}
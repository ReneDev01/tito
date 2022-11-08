import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/views/courses/resumer.dart';

import '../../components/constante.dart';
import '../../controllers/locale_start_point.dart';
import '../../controllers/locale_store.dart';
import '../../controllers/strict_local_storage.dart';
import '../../controllers/trip_controller.dart';
import '../../models/api_response.dart';

class MapNeighboord extends StatefulWidget {
  const MapNeighboord({super.key});

  @override
  State<MapNeighboord> createState() => _MapNeighboordState();
}

class _MapNeighboordState extends State<MapNeighboord> {
  final _formKey = GlobalKey<FormState>();
  final startDescription = TextEditingController();
  final endDescription = TextEditingController();
  final phone = TextEditingController();
  final startLat = TextEditingController();
  final startLng = TextEditingController();
  final endLat = TextEditingController();
  final endLng = TextEditingController();
  final start_address_id = TextEditingController();
  final end_address_id = TextEditingController();
  final district_id = TextEditingController();

  bool isVisible = false;

  late double lat_start = 0;
  late double lng_start = 0;
  late double lat_end = 0;
  late double lng_end = 0;
  int striId = 0;

  void getDistrictId() {
    Map<String, dynamic> cmdStrict =
        json.decode(storageStrict.getItem('cmdStrict'));
    print(cmdStrict);
    striId = cmdStrict['id'];

    setState(() {});
  }

  void getCourseStartMapsInformation() {
    Map<String, dynamic> data = json.decode(storage.getItem('data'));
    lat_start = data['latStart'];
    lng_start = data['lngStart'];

    setState(() {});
  }

  void _registerTrip() async {
    ApiResponse response = await makeTrip(
      phone.text,
      startDescription.text,
      endDescription.text,
      {"lat": startLat.text, "lng": startLng.text},
      {"lat": 0.0, "lng": 0.0},
      district_id.text,
      start_address_id.text,
      end_address_id.text,
    );
    if (response.error == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Resumer()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  /* void removeItemFromLocalStorage() {
    storage.deleteItem('latStart');
    storage.deleteItem('lngStart');
    storage.deleteItem('data');
    storageStrict.deleteItem('id');
    storageStrict.deleteItem('cmdStrict');
  } */

  @override
  void initState() {
    getDistrictId();
    getCourseStartMapsInformation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              //SizedBox(height: MediaQuery.of(context).size.height*0.12,),
              Container(
                child: Text(
                  "Complèté les informations de ma course.",
                  style: GoogleFonts.poppins(
                      color: appBlackColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              myInputTextFormField(
                                appBlackColor,
                                Colors.white12,
                                appColor,
                                "Telephone (00000000)",
                                phone,
                                'Phone',
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              newInputTextFormField(
                                appBlackColor,
                                Colors.white12,
                                appColor,
                                "Décriver votre depart (Ex: A côté de 2 lions)",
                                startDescription,
                                'Actuel place',
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              newInputTextFormField(
                                appBlackColor,
                                Colors.white12,
                                appColor,
                                "Décriver votre destination (Ex: A côté de 2 lions)",
                                endDescription,
                                'Destination place',
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Visibility(
                                  visible: isVisible,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        newInputTextFormField(
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "latitude",
                                          endLat,
                                          'latitude',
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        newInputTextFormField(
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "longitude",
                                          endLng,
                                          'longitude',
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        newInputTextFormField(
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "longitude",
                                          startLat,
                                          'longitude',
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        newInputTextFormField(
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "longitude",
                                          startLng,
                                          'longitude',
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        newInputTextFormField(
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "start district",
                                          district_id,
                                          'start district',
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        newInputTextFormField(
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "end district",
                                          start_address_id,
                                          'end district',
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        newInputTextFormField(
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "end district",
                                          end_address_id,
                                          'end district',
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 30, right: 30),
                child: myFlatButton(
                    appBlackColor, Colors.white, 'Commander', appBlackColor,
                    () {
                  startLat.text = "${lat_start}";
                  startLng.text = "${lng_start}";
                  district_id.text = striId.toString();
                  _registerTrip();
                  //removeItemFromLocalStorage();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

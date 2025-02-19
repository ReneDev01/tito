import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/views/courses/resumer.dart';

import '../../components/constante.dart';
import '../../controllers/client_controller.dart';
import '../../controllers/locale_store.dart';
import '../../controllers/trip_controller.dart';
import '../../models/api_response.dart';
import 'package:localstorage/localstorage.dart';

import 'package:http/http.dart' as http;

class CourseAdress extends StatefulWidget {
  const CourseAdress({super.key});

  @override
  State<CourseAdress> createState() => _CourseAdressState();
}

class _CourseAdressState extends State<CourseAdress> {
  final LocalStorage storageAdress = LocalStorage('localstorage_app');
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
  late double lat_end = 0.0;
  late double lng_end = 0.0;
  int strId = 0;

  void getCourseMapsInformation() {
    Map<String, dynamic> info = json.decode(save.getItem('info'));
    lat_end = info['latEnd'];
    lng_end = info['lngEnd'];

    setState(() {});
    print(info);
  }

  void getAdressId() {
    Map<String, dynamic> cmdAdress =
        json.decode(storageAdress.getItem('cmdAdress'));
    print(cmdAdress);
    strId = cmdAdress['id'];
    setState(() {});
    print(strId);
  }

  void _registerTrip() async {
    ApiResponse response = await makeTrip(
      phone.text,
      startDescription.text,
      endDescription.text,
      {"lat": 0.0, "lng": 0.0},
      {"lat": endLat.text, "lng": endLng.text},
      district_id.text,
      start_address_id.text,
      end_address_id.text,
    );

    if (response.error == null) {
    print(response.data);
    Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Resumer()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}'))); 
    }
  }

  /* void removeItemFromLocalStorage() {
    save.deleteItem('latEnd');
    save.deleteItem('lngEnd');
    save.deleteItem('info');
    storageAdress.deleteItem('id');
    storageAdress.deleteItem('cmdAdress');
  } */

  @override
  void initState() {
    getAdressId();
    getCourseMapsInformation();
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
                                        )
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
                  endLat.text = "${lat_end}";
                  endLng.text = "${lng_end}";
                  start_address_id.text = strId.toString();
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

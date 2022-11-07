import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/controllers/const_url.dart';
import 'package:tito/views/auth/login.dart';
import 'package:tito/views/compte/compte.dart';
import 'package:tito/views/compte/place/adress_list.dart';
import 'package:tito/views/courses/destination.dart';
import 'package:tito/views/courses/resumer.dart';

import '../../../../components/constante.dart';
import '../../../controllers/adress_controller.dart';
import '../../../models/api_response.dart';

class Place extends StatefulWidget {
  double latitude;
  double longitude;
  Place({Key? key, required this.latitude, required this.longitude})
      : super(key: key);
  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final lat = TextEditingController();
  final lng = TextEditingController();
  final description = TextEditingController();
  //final adress = TextEditingController();

  bool isVisible = false;

  void _registerAdress() async {
    ApiResponse response =
        await saveAdress(name.text, description.text, lat.text, lng.text);
    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AdressList()),
        (route) => false);
    }else if(response.error == unauthorized){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false);
    }
     else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBlackColor,
        title: Text(
          "Tito TOGO",
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
                    child: Text(
                  "Enrégistrer une addresse new",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: appBlackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
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
                                "Nom de l'addresse",
                                name,
                                'Nom',
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              newInputTextFormField(
                                appBlackColor,
                                Colors.white12,
                                appColor,
                                "end district",
                                description,
                                'end district',
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
                                          lat,
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
                                          lng,
                                          'longitude',
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: myFlatButton(appBlackColor, Colors.white,
                                    'Enrégistrer', appBlackColor, () async {
                                  lat.text = "${widget.latitude}";
                                  lng.text = "${widget.longitude}";
                                  _registerAdress();
                                }),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

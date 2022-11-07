import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/controllers/adress_controller.dart';


import '../../../../components/constante.dart';
import '../../../controllers/locale_start_point.dart';
import '../../../controllers/locale_store.dart';
import '../../../models/api_response.dart';

class CustomerPlace extends StatefulWidget {
  double latitude;
  double longitude;
  CustomerPlace({Key? key, required this.latitude, required this.longitude})
      : super(key: key);
  @override
  State<CustomerPlace> createState() => _CustomerPlace();
}

class _CustomerPlace extends State<CustomerPlace> {

  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final lat = TextEditingController();
  final lng = TextEditingController();
  final description = TextEditingController();

  bool isVisible = false;
  late double lat_start = 0;
  late double lng_start = 0;
  late double lat_end = 0;
  late double lng_end = 0;
  
  get json => null;

  void getCourseMapsInformation() {
    Map<String, dynamic> info = json.decode(save.getItem('info'));
      lat_end = info['latEnd'];
      lng_end = info['lngEnd'];

    /* print(lat_end);
    print(lng_end); */
    setState(() {});
  }

  void _registerTrip() async {
    ApiResponse response = await saveAdress(
      name.text,
      description.text,
      lat.text,
      lng.text
    );
    if (response.error == null) {
     /*  Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Resumer())); */
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void removeItemFromLocalStorage() {
    storage.deleteItem('latStart');
    storage.deleteItem('lngStart');
    storage.deleteItem('data');
    save.deleteItem('lat_end');
    save.deleteItem('lngEnd');
    save.deleteItem('info');
  }

  @override
  void initState() {
    getCourseMapsInformation();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
          backgroundColor: appBlackColor,
          title: Text(
            "Tito TOGO",
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
                child: Text(
                  "Enrégistrer une addresse",
                  textAlign:TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: appBlackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
              )),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
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
                            height:
                                MediaQuery.of(context).size.height *
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
                          child: myFlatButton(
                              appBlackColor,
                              Colors.white,
                              'Enrégistrer',
                              appBlackColor, () async {
                                setState(() {

                                 lat.text = "${lat_end}";
                                 lng.text = "${lng_end}";

                                 print(lat.text);
                                 print(lng.text); 
                                });
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
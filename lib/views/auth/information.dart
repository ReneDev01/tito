import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/controllers/client_controller.dart';
import 'package:tito/models/api_response.dart';

import '../../components/constante.dart';
import '../navigation.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final _formKey = GlobalKey<FormState>();
  final full_nameText = TextEditingController();
  final whatsap_numberText = TextEditingController();

  void _addInformations() async {
    ApiResponse response =
        await infosCompleteClient(full_nameText.text, whatsap_numberText.text);
    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Navigation()),
          (route) => false);
    } else {
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
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Complèter vos informations",
                    //textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: appBlackColor,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Center(
                  child: Column(
                    children: [
                      Container(
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  myInputTextFormField(
                                      appBlackColor,
                                      Colors.white12,
                                      appColor,
                                      "Entrez-votre nom complet",
                                      full_nameText,
                                      'Nom complet'),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  myInputTextFormField(
                                      appBlackColor,
                                      Colors.white12,
                                      appColor,
                                      "Entrez-votre numero whatsap",
                                      whatsap_numberText,
                                      'Numero whatsapp'),
                                ],
                              ))),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: myFlatButton(appBlackColor, Colors.white,
                            "S'enrégistrer", appBlackColor, () async {
                          if (_formKey.currentState!.validate()) {
                            _addInformations;
                          }
                          ;
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

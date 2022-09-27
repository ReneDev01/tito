import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tito/components/constante.dart';
import 'package:tito/views/auth/register.dart';
import 'package:tito/views/navigation.dart';


import '../../controllers/client_controller.dart';
import '../../models/api_response.dart';
import '../../models/client.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneText = TextEditingController();
  bool passenable = true;

  final _formKey = GlobalKey<FormState>();

  void _loginClient() async {
    ApiResponse response = await login(phoneText.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as Map);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  void _saveAndRedirectToHome(Map data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', data["token"] ?? '');
    await pref.setInt('clientId', data["client"]["id"] ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Navigation()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          backgroundColor: appBlackColor,
          title: Text(
            "Login",
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
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Se Loguer",
                          //textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: appBlackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Container(
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text:
                                  'Connectez-vous pour vivre lancer votre course avec ',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
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
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                                    "Entrez-votre numero",
                                    phoneText,
                                    'Numero',
                                  ),
                                ],
                              ))),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: myFlatButton(appBlackColor, Colors.white,
                            'Se Connecter', appBlackColor, () {
                          if (_formKey.currentState!.validate()) {
                            _loginClient();
                          }
                        }),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Container(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "Vous n'avez pas de compte? ",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                letterSpacing: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Créer un compte',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: appColor,
                                  ),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Register()))
                                        },
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

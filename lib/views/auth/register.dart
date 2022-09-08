import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tito/components/constante.dart';
import 'package:tito/controllers/client_controller.dart';
import 'package:tito/models/Client.dart';
import 'package:tito/models/api_response.dart';
import 'package:tito/views/auth/login.dart';
import 'package:tito/views/navigation.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final usernameText = TextEditingController();
  final phone_numberText = TextEditingController();
  final passwordText = TextEditingController();

  bool loading = false;

  void _registerClient() async {
    ApiResponse response = await createClient(
        usernameText.text, phone_numberText.text, passwordText.text);
        print(response.error);
    if (response.error == null) {
      _saveAndRedirect(response.data as Client);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirect(Client client) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', client.token ?? '');
    await pref.setInt('clientId', client.id ?? 0);
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
            "S'enrégistrer",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: appBackground,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(color: appBlackColor),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Créer un compte",
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
                                  'Créer un compte pour commencer votre aventure avec ',
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
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
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
                                          "Entrez-votre nom d'utilisateur",
                                          usernameText,
                                          'username',
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        myInputTextFormField(
                                            appBlackColor,
                                            Colors.white12,
                                            appColor,
                                            "Entrez-votre Telephone",
                                            phone_numberText,
                                            'numero'),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        myPasswordTextFormField(
                                          //passenable = true,
                                          appBlackColor,
                                          Colors.white12,
                                          appColor,
                                          "Entrez-votre login",
                                          passwordText,
                                        )
                                      ],
                                    ))),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04),
                            Container(
                              child: myFlatButton(appBlackColor, Colors.white,
                                  "S'enrégistrer", appBlackColor, () {
                                if (_formKey.currentState!.validate()) {
                                  _registerClient();
                                }
                              }),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04),
                            Container(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "Vous avez déjà un compte? ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                      letterSpacing: 1,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Connectez-vous',
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
                                                            Login()))
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

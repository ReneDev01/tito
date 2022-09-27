import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tito/components/constante.dart';
import 'package:tito/controllers/client_controller.dart';
import 'package:tito/views/navigation.dart';

import '../../models/api_response.dart';

class Validate extends StatefulWidget {
  final String request_code;
  const Validate({super.key, required this.request_code});

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  final _formKey = GlobalKey<FormState>();
  final request_codeText = TextEditingController();
  final confirmed_codeText = TextEditingController();
  final letter1 = TextEditingController();
  final letter2 = TextEditingController();
  final letter3 = TextEditingController();
  final letter4 = TextEditingController();

  void _validateClient() async {
    ApiResponse response =
        await validatePhone(request_codeText.text, confirmed_codeText.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as Map);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
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

  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          backgroundColor: appBlackColor,
          title: Text(
            "Valider votre numero",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: appBackground,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 170,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/validate.jpg"))),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text(
                  'Entrer le code reçus par SMS',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: appBlackColor,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 60,
                            width: 55,
                            child: TextFormField(
                              controller: letter1,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: appBlackColor, width: 1.0),
                                ),
                                filled: true,
                                fillColor: appBlackColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: appBlackColor, width: 1.0),
                                ),
                              ),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 55,
                            child: TextFormField(
                              controller: letter2,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: appBlackColor, width: 1.0),
                                ),
                                filled: true,
                                fillColor: appBlackColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: appBlackColor, width: 1.0),
                                ),
                              ),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 55,
                            child: TextFormField(
                              controller: letter3,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: appBlackColor, width: 1.0),
                                ),
                                filled: true,
                                fillColor: appBlackColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: appBlackColor, width: 1.0),
                                ),
                              ),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 55,
                            child: TextFormField(
                              controller: letter4,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: appBlackColor, width: 1.0),
                                ),
                                filled: true,
                                fillColor: appBlackColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: appBlackColor, width: 1.0),
                                ),
                              ),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                          visible: isVisible,
                          child: Column(
                            children: [
                              Container(
                                child: myInputTextFormField(
                                  appBlackColor,
                                  Colors.white12,
                                  appColor,
                                  "code",
                                  request_codeText,
                                  'code',
                                ),
                              ),
                              Container(
                                child: myInputTextFormField(
                                  appBlackColor,
                                  Colors.white12,
                                  appColor,
                                  "code",
                                  confirmed_codeText,
                                  'code',
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: myFlatButton(
                            appColor, Colors.white, 'Valider', appColor, () {
                          confirmed_codeText.text = letter1.text + letter2.text + letter3.text + letter4.text;
                          request_codeText.text = widget.request_code;
                          _validateClient();
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

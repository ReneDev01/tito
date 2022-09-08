import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/views/auth/login.dart';
import 'package:tito/views/auth/register.dart';

import '../components/constante.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                //margin: EdgeInsets.only(top: 20, bottom: 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/taxi_moto2.png"))),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                //margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Bienvenue sur ',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
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
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Avez-vous déjà un compte?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: myFlatButton(appBlackColor, appBackground,
                                  'Se connecter', appBackground, () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Login()));
                              }),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              '- ou -',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: myFlatButton(appBackground, appBlackColor,
                                  'Créer un compte', appBlackColor, () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Register()));
                              }),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

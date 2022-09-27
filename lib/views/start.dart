import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/components/constante.dart';
import 'package:tito/views/welcome.dart';

class Start extends StatefulWidget {
  Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue2,
      body: Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07),
                        Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("images/tito.jpeg"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Column(
                      children: [
                        Text(
                          'tito TOGO',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
                    ),
                    Column(
                      children: [
                        Text(
                          "Lorem Ipsum has been the industry's standard dummy.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.09,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: myFlatButton(appBlackColor, Colors.white, 'COMMENCER', appBlackColor, () {
                        _navigateToNextScreen(context);;
                      }),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text("Lorem Ipsum has been the",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.004,
                          ),
                          Column(
                            children: [
                              Text("Lorem Ipsum ",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                    
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Welcome()));
  }
}

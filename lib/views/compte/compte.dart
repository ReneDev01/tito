import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/controllers/client_controller.dart';
import 'package:tito/models/api_response.dart';
import 'package:tito/views/compte/history.dart';
import 'package:tito/views/compte/infos.dart';
import 'package:tito/views/compte/wallet.dart';

import '../../components/constante.dart';
import '../../models/client.dart';

class Compte extends StatefulWidget {
  Compte({Key? key}) : super(key: key);

  @override
  State<Compte> createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  String full_name = "";
  String username = "";
  String phone = "";
  _getAuthClient() async {
    ApiResponse response = await getClientDetails();
    setState(() {
      var client = response.data as Map;
      full_name = client["full_name"];
      username = client["username"];
      phone = client["phone_number"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getAuthClient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBlackColor,
        title: Text(
          "Mon compte",
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Infos()));
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: appIconFontColor2,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.settings,
                                      size: 35,
                                      color: appBlackColor,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Text(
                                      "Infos",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: appBlackColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Wallet()));
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: appIconFontColor2,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.wallet_rounded,
                                      size: 35,
                                      color: appBlackColor,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Text(
                                      "Wallet",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: appBlackColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => History()));
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: appIconFontColor2,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.history_rounded,
                                      size: 35,
                                      color: appBlackColor,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Text(
                                      "Historiques",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: appBlackColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: RichText(
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: "${username} ",
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: appBlackColor,
                                letterSpacing: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: "${full_name} ",
                                  style: GoogleFonts.poppins(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: appBlackColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "${phone}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: appBlackColor,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Infos()));
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("images/person.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Icon(
                            Icons.mail,
                            size: 40,
                            color: appBlackColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Consulter mes messages",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: appBlackColor),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/components/constante.dart';

class Wallet extends StatefulWidget {
  Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBlackColor,
        title: Text(
          "Wallet",
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
                alignment: Alignment.topLeft,
                child: Text(
                  "Portefeuille",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: appBlackColor,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Container( 
                height: MediaQuery.of(context).size.height*0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: appBlackColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Solde : ",
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: appBackground,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        " 2500 FCFA",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: appBackground
                        )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mes opérations",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: appBlackColor
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.75,
                      child: ListView(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: blue3,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.location_on,
                                    color: appBackground,
                                    size: 30,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Agbalepedo",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: appBackground
                                    )
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: Text(
                                    "700",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: appBackground
                                    )
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: blue3,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.location_on,
                                    color: appBackground,
                                    size: 30,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Agbalepedo",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: appBackground
                                    )
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: Text(
                                    "700",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: appBackground
                                    )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                    ),
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
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/components/constante.dart';
import 'package:tito/views/compte/compte.dart';
import 'package:tito/views/courses/course.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
          backgroundColor: appBlackColor,
          title: Text(
            "Tito Togo",
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
                height: MediaQuery.of(context).size.height*0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: appColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Où allez-vous?  ",
                        style:GoogleFonts.poppins(
                          fontSize: 25,
                          color: appBackground,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward, color: appBackground,
                      size: 40,
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

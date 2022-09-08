import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/components/constante.dart';

class Infos extends StatefulWidget {
  Infos({Key? key}) : super(key: key);

  @override
  State<Infos> createState() => _InfosState();
}

class _InfosState extends State<Infos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBlackColor,
        title: Text(
          "Mes informations",
          style: GoogleFonts.poppins(
            color: appBackground,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
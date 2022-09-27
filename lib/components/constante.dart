import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* color constate */
Color appColor = const Color(0xFF0a22ab);
Color blue2 = const Color(0xFF2860af);
Color blue3 = const Color(0xFF3071cd);
Color appBackground = const Color(0xFFebf6fa);
Color appBlackColor = Color.fromARGB(255, 1, 19, 37);

Color appIconFontColor1 = const Color(0xFFf6f2f1);
Color appIconFontColor2 = const Color(0xFFe7f0f7);

bool passenable = false;

TextButton myFlatButton(Color color, Color textColor, String text,
    Color borderColor, Function onPressed) {
  return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: borderColor)),
        backgroundColor: color,
        padding: EdgeInsets.all(15),
        minimumSize: Size(200, 30)
      ),
      onPressed: () => onPressed(),
      child: Text(text,
          style:
              GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.w600,color: textColor
              )),
      );
}


TextFormField myInputTextFormField(
    Color borderSideColor,
    Color fillColor,
    Color enableBorderColor,
    String labelText,
    TextEditingController myController,
    String text,
    ) {
  return TextFormField(
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: borderSideColor, width: 2.0),
      ),
      labelText: labelText,
      labelStyle: GoogleFonts.poppins(
          fontSize: 15, color: appBlackColor, fontWeight: FontWeight.w400),
      filled: true,
      fillColor: fillColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: enableBorderColor, width: 2.0),
      ),
    ),
    style: GoogleFonts.poppins(
      color: appBlackColor,
      fontSize: 15,
    ),
    controller: myController,
    validator: (value) {
      if(value!.isEmpty){
        return " ${text} invalide";
      }else{
        return null;
      }
    }
  );
}

TextFormField myPassTextFormField(
    Color borderSideColor,
    Color fillColor,
    Color enableBorderColor,
    String labelText,
    TextEditingController myController,
    String text,
    ) {
  return TextFormField(
    obscureText: true,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: borderSideColor, width: 2.0),
      ),
      labelText: labelText,
      labelStyle: GoogleFonts.poppins(
          fontSize: 15, color: appBlackColor, fontWeight: FontWeight.w400),
      filled: true,
      fillColor: fillColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: enableBorderColor, width: 2.0),
      ),
    ),
    style: GoogleFonts.poppins(
      color: appBlackColor,
      fontSize: 15,
    ),
    controller: myController,
    validator: (value) {
      if(value!.isEmpty){
        return " ${text} invalide";
      }else{
        return null;
      }
    }
  );
}


DropdownButtonFormField myDropdownButton(Color borderSideColor, Color fillColor,
    Color enableBorderColor, String labelText, Function onChanged, List<DropdownMenuItem<dynamic>> items ) {
  return DropdownButtonFormField(
    items: items,
    dropdownColor: appBackground,
    onChanged: (value) => onChanged(),
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: borderSideColor, width: 2.0),
      ),
      labelText: labelText,
      labelStyle: GoogleFonts.poppins(
          fontSize: 15, color: appBlackColor, fontWeight: FontWeight.w400),
      filled: true,
      fillColor: fillColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: enableBorderColor, width: 2.0),
      ),
    ),
    style: GoogleFonts.poppins(
      color: appBlackColor,
      fontSize: 15,
    ),
    borderRadius: BorderRadius.circular(30.0),

    icon: Padding(
      padding: EdgeInsets.only(left: 20),
      child: Icon(Icons.arrow_circle_down_sharp, color: appBlackColor,),
    ),
    
  );
}

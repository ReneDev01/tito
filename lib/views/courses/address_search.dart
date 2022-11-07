import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/components/constante.dart';

class AddressSearch extends StatelessWidget {
  const AddressSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
          backgroundColor: appBlackColor,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 12, 22, 112),
                      ),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    hintStyle: GoogleFonts.poppins(color: appBlackColor),
                    border: InputBorder.none),
                style: GoogleFonts.poppins(color: appBlackColor),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              placeResults(context),
              SizedBox(height: 10,),
              placeResults(context),
              SizedBox(height: 10,),
              placeResults(context),
              SizedBox(height: 10,),
              placeResults(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget placeResults(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: appBlackColor, width: 3),
          color: appBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Agoè 2 lions",
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                          color: appBlackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            "6.196146",
                            maxLines: 2,
                            style: GoogleFonts.poppins(
                                color: appBlackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          child: Text(
                            "1.200136",
                            maxLines: 2,
                            style: GoogleFonts.poppins(
                                color: appBlackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15, bottom: 12),
              child: Icon(
                Icons.location_on_rounded,
                color: appColor,
                size: 30,
              ),
            ),
          ],
        ),
      );
}

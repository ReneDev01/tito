import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/constante.dart';
import '../../controllers/adress_local_storage.dart';
import '../../controllers/locale_start_point.dart';
import '../../controllers/locale_store.dart';
import '../../controllers/second_adress_storage.dart';
import '../../controllers/strict_local_storage.dart';
import '../navigation.dart';

class Resumer extends StatefulWidget {
  const Resumer({super.key});

  @override
  State<Resumer> createState() => _ResumerState();
}

class _ResumerState extends State<Resumer> {
  void removeItemFromLocalStorage() {
    storageAdress.deleteItem('id');
    storageAdress.deleteItem('cmdAdress');
    storageStrict.deleteItem('id');
    storageStrict.deleteItem('cmdStrict');
    storageSecondAdress.deleteItem('id');
    storageSecondAdress.deleteItem('cmdAdressArv');
    storage.deleteItem('latStart');
    storage.deleteItem('lngStart');
    storage.deleteItem('data');
    save.deleteItem('lat_end');
    save.deleteItem('lngEnd');
    save.deleteItem('info');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBlackColor,
        title: Text(
          "Tito Togo",
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
                child: Text(
                  "Resumer de ma course.",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: appBlackColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.50,
                /* decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: appBlackColor, width: 3),
                  color: appBackground,
                ), */
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Depart : ',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: appColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Agoè-Logopé',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: appBlackColor,
                              ),
                            ),
                          ])),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Destination : ',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: appColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Agbalépédo',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: appBlackColor,
                              ),
                            ),
                          ])),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Kilomètre : ',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: appColor,
                              ),
                            ),
                            TextSpan(
                              text: '4',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: appBlackColor,
                              ),
                            ),
                          ])),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Prix approximatif : ',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: appColor,
                              ),
                            ),
                            TextSpan(
                              text: '700 FCFA',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: appBlackColor,
                              ),
                            ),
                          ])),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 30, right: 30),
                            child: myFlatButton(appBlackColor, Colors.white,
                                'Valider la course', appBlackColor, () {
                              removeItemFromLocalStorage();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Navigation()),
                                  (route) => false);
                            }),
                          )
                        ],
                      ),
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/models/adress.dart';
import 'package:tito/views/compte/compte.dart';
import 'package:tito/views/courses/address_search.dart';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../../../components/constante.dart';
import '../../../controllers/auth_controller.dart';

class AdressList extends StatefulWidget {
  const AdressList({super.key});

  @override
  State<AdressList> createState() => _AdressListState();
}

class _AdressListState extends State<AdressList> {
  List<Adress>? adressL = [];

  //final LocalStorage storageAdress = LocalStorage('localstorage_app');

  Future<void> _getAdressList() async {
    String token = await getToken();
    var result = await http.get(
      Uri.parse("http://145.239.198.239:8090/api/addresses"),
      headers: {
        'Accept': 'application/json', 
        'Authorization': 'Bearer $token',
      },
    );
    print(result.body);
    adressL = jsonDecode(result.body)
        .map((item) => Adress.fromJson(item))
        .toList()
        .cast<Adress>();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _getAdressList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBlackColor,
        title: const Text('Tito TOGO'),
        actions: [
          // Navigate to the Search Screen
          IconButton(onPressed: () {}, icon: const Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              adressLList(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                child: Text(
                  "-Fin-",
                  style: GoogleFonts.poppins(color: appBlackColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget adressLList() {
    return adressL != null
        ? Container(
            margin: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: adressL!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int itemIndex) =>
                        GestureDetector(
                            onTap: () async {},
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: appBlackColor, width: 3),
                                color: appBackground,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      
                                      children: [
                                        Container(
                                          child: Text(
                                            "${adressL![itemIndex].name}",
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                                color: appBlackColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.location_on_rounded,
                                            color: appColor,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ), 
                                  )
                                ],
                              ),
                            )))))
        : Container();
  }
}

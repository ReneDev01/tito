import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tito/models/adress.dart';
import 'package:tito/views/courses/course_adress_adress.dart';
import 'package:tito/views/courses/second_destination.dart';

import '../../components/constante.dart';
import '../../controllers/adress_controller.dart';
import '../../controllers/adress_local_storage.dart';
import '../../controllers/client_controller.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../../controllers/second_adress_storage.dart';
import '../../models/api_response.dart';

class SecondAdress extends StatefulWidget {
  const SecondAdress({super.key});

  @override
  State<SecondAdress> createState() => _SecondAdressState();
}

class _SecondAdressState extends State<SecondAdress> {
  List<Adress>? adress = [];
  final nameText = TextEditingController();

  final LocalStorage storageAdress = LocalStorage('localstorage_app');

  Future<void> _getLitsDistrict() async {
    String token = await getToken();
    var result = await http.get(
      Uri.parse("http://145.239.198.239:8090/api/addresses"),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    adress = jsonDecode(result.body)
        .map((item) => Adress.fromJson(item))
        .toList()
        .cast<Adress>();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _getLitsDistrict();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBlackColor,
        title: const Text('Tito TOGO'),
        /* actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () {
                /* showSearch(context: context, delegate: NeighborhoodSearch()); */
              },
              icon: const Icon(Icons.search))
        ], */
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              adressList(),
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

  Widget adressList() {
    return adress != null
        ? Container(
            margin: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: adress!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int itemIndex) =>
                        GestureDetector(
                            onTap: () async {
                              ApiResponse response = await getAdressInfo(
                                  int.parse("${adress![itemIndex].id}"));
                              var address = response.data as Map;
                              print(address['id']);
                              addItemsSecondAdressStore(address['id']);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CoureseTwoAdress()));
                            },
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
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Text(
                                            "${adress![itemIndex].name}",
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                                color: appBlackColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 15, bottom: 12),
                                    child: Icon(
                                      Icons.location_on_rounded,
                                      color: appColor,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            )))))
        : Container();
  }
}

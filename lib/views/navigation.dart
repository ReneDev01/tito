import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tito/controllers/location_controller.dart';
import 'package:tito/views/compte/compte.dart';
import 'package:tito/views/course.dart';
import 'package:tito/views/home.dart';
import 'package:tito/views/place/place.dart';

import '../bloc/geolocation/geolocation_bloc.dart';
import '../components/constante.dart';
import '../repository/geolocation_repository.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  GlobalKey<CurvedNavigationBarState> _NavKey = GlobalKey();
  var pagesAll = [Home(), Course(), Compte()];
  var myIndex = 0;
  @override
  Widget build(BuildContext context) {
    //Get.put(LocationController());
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _NavKey,
        height: 50,
        backgroundColor: appColor,
        color: appBlackColor,
        animationDuration: Duration(milliseconds: 600),
        animationCurve: Curves.easeInOutQuart,
        items: <Widget>[
          Icon(Icons.home, size: 35),
          Icon(Icons.add, size: 35),
          Icon(Icons.person, size: 35)
        ],
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
      ),
      body: pagesAll[myIndex],
    );
  }
}

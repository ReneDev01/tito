import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tito/blocs/application_block.dart';
import 'package:tito/views/compte/compte.dart';
import 'package:tito/views/course.dart';
import 'package:tito/views/home.dart';
import 'package:tito/views/place/place.dart';

import '../components/constante.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  GlobalKey<CurvedNavigationBarState> _NavKey = GlobalKey();
  var PagesAll = [Home(), Course(), Place() ,Compte()];
  var myIndex = 0;
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
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
          Icon(Icons.person_pin_circle_outlined, size: 35),
          Icon(Icons.person, size: 35)
        ],
        onTap: (index){
          setState(() {
            myIndex = index;
          });
        },
      ),
      body: PagesAll[myIndex],
    );
  }
}

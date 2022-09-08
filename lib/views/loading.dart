import 'package:flutter/material.dart';
import 'package:tito/components/constante.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: appBackground,
      child: Center(
        child: CircularProgressIndicator(color: appColor),
      ),
    );
  }
}
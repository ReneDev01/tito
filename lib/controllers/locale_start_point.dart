import 'dart:convert';

import 'package:localstorage/localstorage.dart';


final LocalStorage storage = LocalStorage('localstorage_app');

void addItemsStartLatLng(double latStart, double lngStart) {
  storage.setItem('latStart', latStart);
  storage.setItem('lngStart', lngStart);

  final data = json.encode({'latStart': latStart, 'lngStart': lngStart});
  storage.setItem('data', data);
}
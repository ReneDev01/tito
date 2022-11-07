import 'dart:convert';

import 'package:localstorage/localstorage.dart';


final LocalStorage save = LocalStorage('localstorage_app');

void addItemsEndLatLng(double latEnd, double lngEnd) {
  save.setItem('latEnd', latEnd);
  save.setItem('lngEnd', lngEnd);

  final info = json.encode({'latEnd': latEnd, 'lngEnd': lngEnd});
  save.setItem('info', info);
}


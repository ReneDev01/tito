import 'dart:convert';

import 'package:localstorage/localstorage.dart';

final LocalStorage storageAdress = LocalStorage('localstorage_app');

void addItemsAdressStore(
  int id,
   ) {
  storageAdress.setItem('id', id);

  final cmdAdress = json.encode({
    'id': id,
    });
  storageAdress.setItem('cmdAdress', cmdAdress);
}
import 'dart:convert';

import 'package:localstorage/localstorage.dart';

final LocalStorage storageSecondAdress = LocalStorage('localstorage_app');

void addItemsSecondAdressStore(
  int id,
   ) {
  storageSecondAdress.setItem('id', id);

  final cmdAdressArv = json.encode({
    'id': id,
    });
  storageSecondAdress.setItem('cmdAdressArv', cmdAdressArv);
}
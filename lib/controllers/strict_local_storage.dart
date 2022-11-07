import 'dart:convert';

import 'package:localstorage/localstorage.dart';

final LocalStorage storageStrict = LocalStorage('localstorage_app');

void addItemsOrderAdress(
  int id,
   ) {
  storageStrict.setItem('id', id);

  final cmdStrict = json.encode({
    'id': id,
    });
  storageStrict.setItem('cmdStrict', cmdStrict);
}
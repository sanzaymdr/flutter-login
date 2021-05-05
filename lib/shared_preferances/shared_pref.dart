import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

addUserToSP(username, response) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(username, jsonEncode(response));
}

getStringValuesSF(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String data = prefs.getString(key) ?? "no response";
  return data; //string
}

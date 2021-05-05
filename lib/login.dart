import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:login/api_services/api_service.dart';

import './login_status.dart';
import './login_validator.dart';
// import './api_services/api_service.dart';
import './shared_preferances/shared_pref.dart';

class LoginProvider extends ChangeNotifier with Validator {
  String _email;
  String _password;
  String _emailError = "**reqd**";
  String _passwordError = "**reqd**";
  LoginStatus _loginStatus = new LoginStatus("not_logged");

  String get getEmail => _email;
  String get getPassword => _password;
  get btnColor => _loginStatus.getButtonColor;
  String get getLoginStatus => _loginStatus.getLoginStat;

  get getEmailError => _emailError;
  get getPasswordError => _passwordError;

  // email setter
  void changeEmail(email) {
    _email = email;
    _emailError = validateEmail(email) ? email : "Invalid Email";
    notifyListeners();
  }

  // password setter
  void changePassword(password) {
    _password = password;
    _passwordError =
        validatePassword(password) ? "Good to go!!!" : "Password Error";
    notifyListeners();
  }

  // on submit button
  void sendPostRequest() async {
    // change login stat to logging and notify listener
    await _loginStatus.setLoginStat("logging");
    notifyListeners();
    var _url = "https://trial.nivid.app/tokenuser_token";
    var _data = {
      "auth": {"email": _email, "password": _password}
    };
    Dio _dio = new Dio();
    try {
      var response = await _dio.post(_url, data: _data);
      await Future.delayed(Duration(seconds: 1));

      if (response.data["jwt"] != null || response.data["jwt"] != "") {
        //change login stat to logged and save to shared preferances
        _loginStatus.setLoginStat("logged");
        addUserToSP(_email, _data);
      } else {
        //if no jwt throw error to catch block
        throw ("No jwt!!!");
      }
    } catch (e) {
      _loginStatus.setLoginStat("failed");
    } finally {
      notifyListeners();
    }
  }
}

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:login/shared_preferances/shared_pref.dart';
import './login_status.dart';
import './login_validator.dart';

// import './api_services/api_service.dart';

class LoginProvider extends ChangeNotifier with Validator {
  String _loginEmailOrNumber;
  String _postUrl;
  String _passwordOrPin;
  Widget _nextpage;

  LoginProvider({
    @required String postUrl,
    @required String loginEmailOrNumber,
    @required String passwordOrPin,
    @required Widget nextpage,
  }) {
    _postUrl = postUrl;
    _loginEmailOrNumber = loginEmailOrNumber;
    _passwordOrPin = passwordOrPin;
    _nextpage = nextpage;
  }

  String _loginId;
  String _password;
  String _loginIdError;
  String _passwordError;
  LoginStatus _loginStatus = new LoginStatus("not_logged");
  String get getLoginId => _loginId;
  String get getPassword => _password;
  get btnColor => _loginStatus.getButtonColor;
  LoginStatus get getLoginStatus => _loginStatus;
  get getIdError => _loginIdError;
  get getPasswordError => _passwordError;
  // email setter
  void changeEmail(id) {
    _loginId = id;
    if (_loginEmailOrNumber == "email") {
      _loginIdError = validateEmail(id) ? "" : "Invalid $_loginEmailOrNumber";
    } else if (_loginEmailOrNumber == "number") {
      _loginIdError = validatePhone(id) ? "" : "Invalid $_loginEmailOrNumber";
    }
    notifyListeners();
  }

  get validated => _loginIdError == "" && _passwordError == "";

  // password setter
  void changePassword(password) {
    _password = password;
    if (_passwordOrPin == "pin") {
      _passwordError = validatePin(password, 4) ? "" : "Pin Error";
    } else if (_passwordOrPin == "password") {
      _passwordError = validatePassword(password) ? "" : "Password Error";
    }
    notifyListeners();
  }

  // on submit button
  void sendPostRequest(context) async {
    // change login stat to logging and notify listener
    await _loginStatus.setLoginStat("logging");
    notifyListeners();
    var _data = {
      "auth": {"email": _loginId, "password": _password}
    };
    Dio _dio = new Dio();
    try {
      var response = await _dio.post(_postUrl, data: _data);
      await Future.delayed(Duration(seconds: 1));
      if (response.data["jwt"] != null || response.data["jwt"] != "") {
        //change login stat to logged and save to shared preferances
        _loginStatus.setLoginStat("logged");
        Future.delayed(Duration(seconds: 1));
        notifyListeners();
        addUserToSP(_loginId, _data);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _nextpage),
        );
      } else {
        //if no jwt throw error to catch block
        throw ("No jwt!!!");
      }
    } catch (e) {
      await _loginStatus.setLoginStat("failed");
      notifyListeners();

      await Future.delayed(Duration(seconds: 1));
      _loginStatus.setLoginStat("not_logged");
    } finally {
      notifyListeners();
    }
  }
}

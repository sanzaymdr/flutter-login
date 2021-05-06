import 'package:flutter/material.dart';

class LoginStatus {
  var _buttonColor;
  String _loginStatus; //logged,logging,not_logged, failed,
  LoginStatus(this._loginStatus);

  get getLoginStat => _loginStatus;
  get getButtonColor => _buttonColor;

  setLoginStat(loginStatus) {
    _loginStatus = loginStatus;
    this._loginStatus = loginStatus;
    switch (loginStatus) {
      case "not_logged":
        {
          _buttonColor = Colors.blue;
        }
        break;

      case "logging":
        {
          _buttonColor = Colors.purple;
        }
        break;
      case "logged":
        {
          _buttonColor = Colors.green;
        }
        break;

      case "failed":
        {
          _buttonColor = Colors.red[40];
        }
        break;

      default:
        {
          print("khatam");
        }
    }
  }
}

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
          _buttonColor = MaterialStateProperty.all(Colors.blue);
        }
        break;

      case "logging":
        {
          _buttonColor = MaterialStateProperty.all(Colors.purple);
        }
        break;
      case "logged":
        {
          _buttonColor = MaterialStateProperty.all(Colors.green);
        }
        break;

      case "failed":
        {
          _buttonColor = MaterialStateProperty.all(Colors.red[400]);
        }
        break;

      default:
        {
          print("khatam");
        }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:login/login_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      home: Login(),
    );
  }
}

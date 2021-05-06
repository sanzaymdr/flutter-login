library login;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './login.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => LoginProvider(
          postUrl: "https://trial.nivid.app/tokenuser_token",
          loginEmailOrNumber: 'number',
          passwordOrPin: 'pin',
          nextpage: Text("Hello"),
        ),
        child: Column(
          children: [
            emailFormField(),
            passwordFormField(),
            submitBtn(),
            verticalGap(),
            Consumer<LoginProvider>(
              builder: (context, loginProvider, child) =>
                  Text(loginProvider.getIdError ?? ""),
            ),
            verticalGap(),
            Consumer<LoginProvider>(
              builder: (context, loginProvider, child) =>
                  Text(loginProvider.getPasswordError ?? "Good to go"),
            ),
          ],
        ),
      ),
    );
  }

  verticalGap() {
    return SizedBox(
      height: 20,
    );
  }

  emailFormField() {
    return Consumer<LoginProvider>(
      builder: (
        context,
        loginProvider,
        child,
      ) =>
          TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          labelText: 'Email *',
        ),
        onChanged: loginProvider.changeEmail,
      ),
    );
  }

  passwordFormField() {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) => TextFormField(
        obscureText: true,
        autocorrect: false,
        enableSuggestions: false,
        decoration: const InputDecoration(
          icon: Icon(Icons.lock),
          labelText: 'Password *',
        ),
        onChanged: loginProvider.changePassword,
      ),
    );
  }

  submitBtn() {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) => ElevatedButton(
        onPressed: () {
          loginProvider.sendPostRequest(context);
        },
        child: Text(loginProvider.getLoginStatus.getLoginStat == 'not_logged'
            ? "Submit"
            : loginProvider.getLoginStatus),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(loginProvider.btnColor),
        ),
      ),
    );
  }
}

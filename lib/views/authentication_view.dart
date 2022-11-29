import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../palette/buttons.dart';
import '../view_models/authentication_viewmodel.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<AuthenticationPage> {
  @override
  void initState() {
    super.initState();
  }

  // Registration form if the user doesn't have an account
  Widget registrationForm() {
    return const Center(
      child: Text('Registration Page'),
    );
  }

  // Login form if the user already has an account
  Widget loginForm() {
    return const Center(
      child: Text('Login Page'),
    );
  }

  Widget authForm() {
    return Form(
      child: Column(children: <Widget>[
        ElevatedButton(
          style: roundedButton,
          onPressed: () {
            Provider.of<AuthenticationViewModel>(context, listen: false).updateState(1);
          },
          child: const Text('Sign In'),
        ),
        ElevatedButton(
          style: roundedButton,
          onPressed: () {
            Provider.of<AuthenticationViewModel>(context, listen: false).updateState(2);
          },
          child: const Text('Register'),
        )])
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? body;

    switch (Provider.of<AuthenticationViewModel>(context, listen: true).state) {
      case 0:
        body = authForm();
        break;
      case 1:
        body = loginForm();
        break;
      case 2:
        body = registrationForm();
        break;
    }

    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Container(
          height: 400,
          width: 400,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/face2face.png'),
          ))),
      Container(
        child: body,
      )
    ]));
  }
}

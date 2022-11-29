import 'package:flutter/material.dart';

import '../palette/buttons.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Container(
          height: 400,
          width: 400,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/face2face.png'),
          ))),
      ElevatedButton(
        style: roundedButton,
        onPressed: () {},
        child: const Text('Sign In'),
      ),
      ElevatedButton(
        style: roundedButton,
        onPressed: () {},
        child: const Text('Register'),
      )
    ]));
  }
}

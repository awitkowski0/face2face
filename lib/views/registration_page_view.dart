import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RegistrationPage> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  ButtonStyle style = ButtonStyle(
      textStyle:
          MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 40)),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(30)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.transparent),
      )));

  // TODO: Add logic for register, logging in, and navigating to the next page through a model that is accessed in this view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(children: <Widget>[
      const Image(
        image: AssetImage('assets/images/face2face.png'),
        width: 400,
        height: 400,
      ),
      ElevatedButton(
        style: style,
        onPressed: () {},
        child: const Text('Sign In'),
      ),
      ElevatedButton(
        style: style,
        onPressed: () {},
        child: const Text('Register'),
      )
    ])) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

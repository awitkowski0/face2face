import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ButtonStyle style = ButtonStyle(
      textStyle:
          MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 40)),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(30)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.transparent),
      )));

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

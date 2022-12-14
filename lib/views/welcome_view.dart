import 'package:face2face/views/account_view.dart';
import 'package:face2face/views/main_view.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const String routeName = "/welcome";

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children:
            [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.20
          ),
          const Card(
            child:
          Text(
            "Welcome to Face2Face! Let's get started by creating you a profile!",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.20
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AccountPage.routeName);
              },
              child: const Text('Get Started!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              )))
        ])
    );
  }
}

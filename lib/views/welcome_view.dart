import 'package:face2face/views/account_view.dart';
import 'package:face2face/views/main_view.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const String routeName = "/welcome";

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const Center(
            child:
          Text(
            "Welcome to Face2Face! Let's get started by creating you a profile!",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
          ),
          FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AccountPage.routeName);
              },
              child: const Text('Get Started!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )))
        ]
    );
  }
}

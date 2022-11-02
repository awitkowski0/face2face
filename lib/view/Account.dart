import 'package:flutter/material.dart';
import 'Login.dart';
import '../model.dart';

class AccountPage extends StatelessWidget {
  AccountPage({this.user});

  static const String routeName = "/Account";
  final User? user;

  @override
  Widget build(BuildContext context) {
    Widget buildBody() {
      return Container(
          child: Column(
            children: [
              Text("Username: ${user!.username}"),
              Text("Email: ${user!.email}"),
              Text("Password: ${user!.password}"),
              Text("Age: ${user!.age}"),
              Text("Gender: "),
              Text("Interested in: ")
            ],
          )
      );
    }
    PreferredSizeWidget _buildAppBar() {
      return AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Account'),
        leading: IconButton(
          alignment: Alignment.centerLeft,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const <Widget>[],
      );
    }
    return Scaffold(
      body: buildBody(),
      appBar: _buildAppBar(),
    );
  }
}
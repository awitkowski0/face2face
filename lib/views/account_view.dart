import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  static const String routeName = "/Account";

  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildBody(){
      return Container(
        child: Column(
          children: [
            Text("Username: "),
            Text("Email: "),
            Text("Age: "),
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
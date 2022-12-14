import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/accounts_viewmodel.dart';
import 'main_view.dart';

class AccountPage extends StatelessWidget {
  static const String routeName = "/account";

  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Card(
            child: Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.20
        ),
        TextFormField(
          controller: context.read<AccountViewModel>().displayNameController,
          decoration: const InputDecoration(
            labelText: 'Display Name',
          ),
        ),
        TextFormField(
          controller: context.read<AccountViewModel>().bioController,
          decoration: const InputDecoration(
            labelText: 'Bio',
          ),
        ),
        TextFormField(
          controller: context.read<AccountViewModel>().majorController,
          decoration: const InputDecoration(
            labelText: 'Major',
          ),
        ),
        TextFormField(
          controller: context.read<AccountViewModel>().occupationController,
          decoration: const InputDecoration(
            labelText: 'Occupation',
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.15
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<AccountViewModel>(context, listen: false).signOut();
            Navigator.pushNamed(context, MyHomePage.routeName);
          },
          child: const Text('Sign Out'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<AccountViewModel>(context, listen: false).modifyUser();
            Navigator.pushNamed(context, MyHomePage.routeName);
          },
          child: const Text('Go Home'),
        ),
      ],
    )));
  }
}

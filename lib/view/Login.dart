import 'package:face2face/view/Account.dart';
import 'package:flutter/material.dart';
import '../model.dart';
import 'package:form_validator/form_validator.dart';
import '../main.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key});

  static final String routeName = "/Login";

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}


class LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();


  void _login() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please check input values')),
      );
    }
  }

  User user = User();

  @override
  Widget build(BuildContext context) {
    Widget _buildBody(){
      return Container(
        child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Email
            TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  hintText: "Email"
              ),
              validator: ValidationBuilder().email().build(),
              onSaved: (String? value) {
                user.email = value;
              },
            ),

            // Password
            TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  hintText: "Password"
              ),
              obscureText: true,
              validator: ValidationBuilder().required("Password is required").build(),
              onSaved: (String? value) {
                user.password = value;
              },
            ),

            // Confirm Button
            ElevatedButton(
              onPressed: _login,
              child: const Text("Login"),
            ),
          ],
        ),
      ));
    }
    return Scaffold(
      body: _buildBody(),
    );
  }

}
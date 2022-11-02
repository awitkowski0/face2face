import 'package:flutter/material.dart';

class User {
  String? username;
  String? email;
  String? password;
  bool loggedIn = false;
  double? age = 0;

  User({this.username, this.email, this.password, this.age});
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'loggedIn': loggedIn,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'Username: $username, Email: $email, Password: $password, Age: $age';
  }
}
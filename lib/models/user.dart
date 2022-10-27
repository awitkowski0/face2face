import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final int age;

  const User({
    required this.id,
    required this.name,
    required this.age,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, name: $name, age: $age}';
  }
}
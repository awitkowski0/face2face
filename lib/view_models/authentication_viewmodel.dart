import 'package:flutter/material.dart';

class AuthenticationViewModel extends ChangeNotifier {
  // The current state, should default to 0 for the auth form
  // 1 is for registration
  // 2 is for login
  int state = 0;

  // Update the registration form state
  void updateState(int newState) {
    state = newState;
    notifyListeners();
  }
}

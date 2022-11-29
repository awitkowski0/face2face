import 'package:firebase_auth/firebase_auth.dart';

User? _user = FirebaseAuth.instance.currentUser;

void authenticateAccount() async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'testuser@pitt.edu',
        password: 'password'
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }

  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      _user = user;
    }
  });
}

getCurrentUser() {
  return _user;
}
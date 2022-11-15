import 'package:face2face/models/photos.dart';
import 'package:face2face/models/user_model.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
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
  upsertUser(
      UserAccount(
        uniqueKey: getCurrentUser()!.uid,
        photos: <Photo>[
          Photo(
            id: 'test',
            url: 'https://picsum.photos/200/300',
            createdAt: DateTime.now().toString(),
          ),
        ],
        displayName: 'James',
        shortBio: 'I like to fish',
        major: 'Actuary Science',
        occupation: 'Student',
        pronouns: 'He/Him',
        age: 20,
      ));
}

getCurrentUser() {
  return _user;
}
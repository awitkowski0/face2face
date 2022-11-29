import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face2face/view_models/chat_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class AccountViewModel extends ChangeNotifier {
  final List<UserAccount> users = [];
  final _auth = FirebaseStorage.instance;
  User? _currentUser = FirebaseAuth.instance.currentUser;

  bool get isInitialized => (_auth.bucket.isNotEmpty);

  /// Currently populates all users from DB
  /// Move to only populate "potential matches"
  Future<void> populateUsers() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('users').get();
    for (final QueryDocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
      users.add(UserAccount.fromJson(document.data()));
    }
  }

  // init firebase, attempt to authenticate the user
  void init() {
    authenticateAccount();
    populateUsers();

    // populate chats @Matt
    populateChat();
  }

  // Authenticate the current user against the Firebase Authentication service.
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
      if (user != null) {
        _currentUser = user;
      }
    });
  }

  // Sign out the current user
  void signOut() {
    FirebaseAuth.instance.signOut();
    _currentUser = null;
  }

  // Grab the current user (should be initialized)
  User? getCurrentUser() {
    return _currentUser;
  }

  // Check if the current user is authenticated
  bool isAuthenticated() {
    return false;

    return _currentUser != null;
  }

  // Get a user's information
  getUser(String uid) {
    if (uid == _currentUser!.uid) {
      return _currentUser;
    }
    return users.firstWhere((element) => element.uniqueKey == uid);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face2face/view_models/chat_viewmodel.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class AccountViewModel extends ChangeNotifier {
  final List<UserAccount> users = [];
  final _firestoreAuth = FirebaseStorage.instance;
  final _firebaseAuth = FirebaseAuth.instanceFor(
      app: Firebase.app(), persistence: Persistence.LOCAL);

  User? _currentUser = FirebaseAuth.instance.currentUser;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final displayNameController = TextEditingController();
  final bioController = TextEditingController();
  final ageController = TextEditingController();
  final majorController = TextEditingController();
  final occupationController = TextEditingController();

  bool get isInitialized => (_firestoreAuth.bucket.isNotEmpty);

  /// Currently populates all users from DB
  /// Move to only populate "potential matches"
  Future<void> populateUsers() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    for (final QueryDocumentSnapshot<Map<String, dynamic>> document
        in querySnapshot.docs) {
      users.add(UserAccount.fromJson(document.data()));
    }
  }

  // init firebase, attempt to authenticate the user
  void init() {
    populateUsers();

    // populate chats @Matt
    populateChat();
    //notifyListeners();
  }

  void createAccount() async {
    try {
      final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      _currentUser = newUser.user;
    } catch (e) {
      print(e);
    }
    authenticateAccount();
    upsertUser(UserAccount(
        uniqueKey: _currentUser!.uid, displayName: _currentUser!.displayName));
  }

  void modifyUser() async {
    UserAccount user = getAccountUser();
    upsertUser(UserAccount(
        uniqueKey: user.uniqueKey,
        displayName: displayNameController.text ?? user.displayName,
        shortBio: bioController.text ?? user.shortBio,
        major: majorController.text ?? user.major,
        occupation: occupationController.text ?? user.occupation
    ));
  }
  // Authenticate the current user against the Firebase Authentication service.
  void authenticateAccount() async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        _currentUser = user;
      }
    });
    notifyListeners();
  }

  // Sign out the current user
  void signOut() {
    _firebaseAuth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // Grab the current user (should be initialized)
  User? getCurrentUser() {
    return _currentUser;
  }

  // Check if the current user is authenticated
  bool isAuthenticated() {
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

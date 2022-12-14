import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face2face/models/photos.dart';
import 'package:face2face/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

final List<UserAccount> users = [];
final storage = FirebaseStorage.instance;

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

// Get the current user
UserAccount getAccountUser() {
  User user = getCurrentUser();

  return users.firstWhere((element) => element.uniqueKey == user.uid);
}

getCurrentUser() {
  return FirebaseAuth.instance.currentUser;
}

// Get a user by their user id
UserAccount getUser(String uid) {
  return users.firstWhere((element) => element.uniqueKey == uid);
}

// Insert or update a user
Future<void> upsertUser(UserAccount user) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uniqueKey.toString())
      .set(user.toJson())
      .onError((error, stackTrace) => print(stackTrace));
  if (!users.contains(user)) {
    users.add(user);
  } else {
    users[users.indexOf(user)] = user;
  }
}

// Create a new photo for the user
Future<void> createPhoto(Uint8List file) async {
  final user = getAccountUser();
  final uid = user.uniqueKey.toString();
  final ref = storage.ref().child('photos/$uid-${DateTime.now()}.jpeg');

  await ref
      .putData(
          file,
          SettableMetadata(
              contentType: 'image/jpeg', customMetadata: {'name': 'photo'}))
      .then((photo) {
    addPhoto(user, photo);
  });
}

// Add a photo to user.photos and update user
Future<void> addPhoto(UserAccount user, TaskSnapshot photo) async {
  final url = await photo.ref.getDownloadURL();
  user.photos!.insert(
      0,
      Photo(
          url: url, createdAt: DateTime.now().toString(), id: photo.ref.name));

  upsertUser(UserAccount(uniqueKey: user.uniqueKey, displayName: user.displayName, shortBio: user.shortBio, age: user.age, occupation: user.occupation, major: user.major, photos: user.photos));
}

class UserViewModel with ChangeNotifier {
  // All chats (that will be displayed on the Home screen)
  late List<UserAccount> _users = users;

  //List<List<Chat>> _byName = [];

  // Retrieve all chats
  List<UserAccount> get allUsers => _users;
}

// This would actually be populated from the database
import 'package:face2face/models/photos.dart';
import 'package:face2face/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final List<UserAccount> users = [];

Future<void> populateUsers() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  for (final QueryDocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
    users.add(UserAccount.fromJson(document.data()));
  }
}

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
}

Future<void> addPhoto(UserAccount user, Photo photo) async {
  if (user.photos?.isEmpty ?? true) {
    user.photos![0] = photo;
  } else {
    user.photos!.insert(0, photo);
  }
  upsertUser(user);
}
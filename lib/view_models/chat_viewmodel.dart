import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication_viewmodel.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

// A list of chats
final List<Chat> initialData = [];

User userLoggedIn = getCurrentUser();

/// Currently populates all users from DB
/// Move to only populate "potential matches"
Future<void> populateChat() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  await FirebaseFirestore.instance.collection('chats').get();
  for (final QueryDocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
    if(document.data()['user1Name'] == "0" || document.data()['user2Name'] == "0") {
      initialData.add(Chat.fromJson(document.data()));
    }
  }
}

// Add new message to the database
Future<void> upsertChat(Chat chat) async {
  await FirebaseFirestore.instance
      .collection('chats')
      .doc('user${chat.user1ID}-user${chat.user2ID}')
      .set(chat.toJson())
      .onError((error, stackTrace) => print(stackTrace));
}

class ChatViewModel with ChangeNotifier {
  // All chats (that will be displayed on the Home screen)
  final List<Chat> _chats = initialData;

  // Retrieve all chats
  List<Chat> get chats => _chats;

  // Retrieve current user chats
  List<Chat> get currUserChats => _chats.where((element) => element.user1ID == "0").toList();

  void sendChat(Message message, String user1ID, String user2ID) {
      // Update chat where logged in user is user1
      Chat toUpdate = _chats.firstWhere((element) => element.user1ID == user1ID && element.user2ID == user2ID);
      toUpdate.messages!.add(message);
      upsertChat(toUpdate);

      // Update other one
      toUpdate = _chats.firstWhere((element) => element.user1ID == user2ID && element.user2ID == user1ID);
      toUpdate.messages!.add(message);
      upsertChat(toUpdate);
      notifyListeners();
  }

}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// A list of chats
final List<Chat> initialData = [
  Chat([Message(1, 0, "Hello", DateTime(2022)), Message(0, 1, "I like fishin", DateTime(2022))], 'Hailey', 'Alex'),
  Chat([Message(2, 0, "Alex is gonna be late for class", DateTime(2022)), Message(0, 2, "I like fishin", DateTime(2022))], 'Hailey', 'Matt'),
];

const String userLoggedIn = "Hailey";

/// Currently populates all users from DB
/// Move to only populate "potential matches"
Future<void> populateChat() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  await FirebaseFirestore.instance.collection('chats').get();
  for (final QueryDocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
    if(document.data()['user1Name'] == userLoggedIn) {
      initialData.add(Chat.fromJson(document.data()));
    }
  }
}

// Add new message to the database
Future<void> upsertChat(Chat chat) async {
  await FirebaseFirestore.instance
      .collection('chats')
      .doc('user${chat.messages![0].senderID}-user${chat.messages![0].receiverID}')
      .set(chat.toJson())
      .onError((error, stackTrace) => print(stackTrace));
}

class ChatViewModel with ChangeNotifier {
  // All chats (that will be displayed on the Home screen)
  final List<Chat> _chats = initialData;

  //List<List<Chat>> _byName = [];

  // Retrieve all chats
  List<Chat> get chats => _chats;

  /*List<List<Chat>> get byName {
    if(_byName.length == 0) {
      for (var name in names) {
        _byName.add(getNamedchats(name));
      }
    }
    return _byName;
  }
  
  List<Chat> getNamedchats(String name){
    return _chats.where((element) => element.user1Name == name || element.user2Name == name).toList();
  }*/

  // Send a chat
  void sendChat(Message message, int index) {
      // Get name index
      _chats[index].messages!.add(message);
      upsertChat(_chats[index]);
      notifyListeners();
  }

}
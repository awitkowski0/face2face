import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat.dart';

// A list of movies
final List<Chat> initialData = [
  Chat([Message(1, 0, "Hello", DateTime(2022)), Message(0, 1, "I like fishin", DateTime(2022))], 'Hailey', 'Alex'),
];
final List<String> allNames = ["Alex", "Matt", "Jacob"];

class ChatViewModel with ChangeNotifier {
  // All chats (that will be displayed on the Home screen)
  final List<Chat> _chats = initialData;
  final List<String> _names = allNames;

  List<String> get names => _names;

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
  void sendChat(Message message) {
      // Get name index
      _chats[message.receiverID].messages.add(message);
      notifyListeners();
  }

}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat.dart';

// A list of movies
final List<Chat> initialData = [
  Chat('Hello', 'Alex', 'Hailey', false),
  Chat('I like Fishin', 'Hailey', 'Alex', true),
  Chat('OMG me too! I like fishin and huntin!', 'Alex', 'Hailey', false),
  Chat('Alex is going to be late to class', 'Matt', 'Hailey', false),
  Chat('At least he\'s coming to class this time', 'Hailey', 'Matt', true),
  Chat('Don\'t forget to do your homework', 'Jacob', 'Hailey', false),
];
final List<String> allNames = ["Alex", "Matt", "Jacob"];

class ChatViewModel with ChangeNotifier {
  // All chats (that will be displayed on the Home screen)
  final List<Chat> _chats = initialData;
  final List<String> _names = allNames;

  List<String> get names => _names;

  List<List<Chat>> _byName = [];

  // Retrieve all chats
  List<Chat> get chats => _chats;

  List<List<Chat>> get byName {
    if(_byName.length == 0) {
      for (var name in names) {
        _byName.add(getNamedchats(name));
      }
    }
    return _byName;
  }
  
  List<Chat> getNamedchats(String name){
    return _chats.where((element) => element.senderName == name || element.receiverName == name).toList();
  }

  // Send a chat
  void sendChat(Chat message) {
      // Get name index
      int index = _names.indexOf(message.receiverName);
      _byName[index].add(message);
      notifyListeners();
  }

}
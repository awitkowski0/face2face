import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat.dart';

// A list of movies
final List<chat> initialData = [
  chat('Hello', 'Alex', 'Hailey', false),
  chat('I like Fishin', 'Hailey', 'Alex', true),
  chat('OMG me too! I like fishin and huntin!', 'Alex', 'Hailey', false),
  chat('Alex is going to be late to class', 'Matt', 'Hailey', false),
  chat('At least he\'s coming to class this time', 'Hailey', 'Matt', true),
  chat('Don\'t forget to do your homework', 'Jacob', 'Hailey', false),
];
final List<String> allNames = ["Alex", "Matt", "Jacob"];

class ChatViewModel with ChangeNotifier {
  // All chats (that will be displayed on the Home screen)
  final List<chat> _chats = initialData;
  final List<String> _names = allNames;

  List<String> get names => _names;

  List<List<chat>> _byName = [];

  // Retrieve all chats
  List<chat> get chats => _chats;

  List<List<chat>> get byName {
    if(_byName.length == 0) {
      for (var name in names) {
        _byName.add(getNamedchats(name));
      }
    }
    return _byName;
  }
  
  List<chat> getNamedchats(String name){
    return _chats.where((element) => element.senderName == name || element.receiverName == name).toList();
  }

  // Send a chat
  void sendChat(chat message) {
      // Get name index
      int index = _names.indexOf(message.receiverName);
      _byName[index].add(message);
      notifyListeners();
  }

}
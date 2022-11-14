import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat.dart';

// A list of movies
final List<chat> initialData = [
  chat('Hello', 'Alex', 'Hailey', false),
  chat('I like Fishin', 'Hailey', 'Alex', true),
  chat('OMG me too! I like fishin and huntin! JACOB BIEHL', 'Alex', 'Hailey', false),
];

class ChatViewModel with ChangeNotifier {
  // All chats (that will be displayed on the Home screen)
  final List<chat> _chats = initialData;

  // Retrieve all chats
  List<chat> get chats => _chats;

  // Send a chat
  void sendChat(chat message) {
      _chats.add(message);
      notifyListeners();
  }

}
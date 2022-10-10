import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    // This method is specific to the camera
    Widget _buildChat() {
      return Column(
        children: const [
          Text('Chat'),
          Text('Three'),
        ],
      );
    }
    return _buildChat();
  }
}
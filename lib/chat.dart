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
      return Container(
        height: 56.0, // in logical pixels
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(color: Color(0xFFFDBAAE)),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width:10,
                  color: Color(0xFF000000)
                ),
                color: Color(0xEFED5AAE)
              ),
              width: 200,
              child: Text(
                "Hello"
              )
            ),
            Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        width:10,
                        color: Color(0xFF000000)
                    ),
                    color: Color(0xEFED5AAE)
                ),
                width: 200,
                child: Text(
                    "Hello"
                )
            ),
          ],
        ),
      );
    }
    return _buildChat();
  }
}
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
  final List<String> names = <String>['Alex', 'Bob', 'Connor', "Dan"];
  final List<String> messages = <String>['I\'m gonna be late to class', 'Hello', 'I LOVE FISHIN', 'Hey girl'];
  int _chats = 2;
  @override
  Widget build(BuildContext context) {
    // This method is specific to the camera
    Widget _buildChat() {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 50.0, left: 8, right: 8),
        decoration: BoxDecoration(color: Color(0xFFFAFAFF)),
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        width:2,
                        color: Color(0xFF606060)
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xFFDDDDDD)
                ),
                width: MediaQuery.of(context).size.width - 20,
                child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left:5)),
                      Image.asset('assets/images/face2face.png'),
                      Padding(padding: EdgeInsets.only(left:8)),
                      Text("${names[index]}", style: TextStyle(fontSize: 20, fontFamily: "Roboto")),
                      Expanded(child: Container()),
                      Text("${messages[index]}", style: TextStyle(fontSize: 15, fontFamily: "Roboto")),
                      Padding(padding: EdgeInsets.only(right:8))
                    ]
                )
            );
          }
        )
      );
    }
    return _buildChat();
  }
}
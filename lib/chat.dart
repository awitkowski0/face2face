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
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(color: Color(0xFFFDCABE)),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 60)),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width:2,
                  color: Color(0xFF606060)
                ),
                color: Color(0xEFEF9A8E)
              ),
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left:5)),
                  Image.asset('assets/images/face2face.png'),
                  Padding(padding: EdgeInsets.only(left:5)),
                  Text("Name", style: TextStyle(fontSize: 20, fontFamily: "Roboto")),
                  Container(
                    width: 250,
                    child: Text("Message", style: TextStyle(fontSize: 20, fontFamily: "Roboto"), textAlign: TextAlign.right,)
                  )
                ]
              )
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        width:2,
                        color: Color(0xFF606060)
                    ),
                    color: Color(0xEFEF9A8E)
                ),
                width: MediaQuery.of(context).size.width - 20,
                child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left:5)),
                      Image.asset('assets/images/face2face.png'),
                      Padding(padding: EdgeInsets.only(left:5)),
                      Text("Name", style: TextStyle(fontSize: 20, fontFamily: "Roboto")),
                      Container(
                          width: 250,
                          child: Text("Message", style: TextStyle(fontSize: 20, fontFamily: "Roboto"), textAlign: TextAlign.right,)
                      )
                    ]
                )
            ),
          ],
        ),
      );
    }
    return _buildChat();
  }
}
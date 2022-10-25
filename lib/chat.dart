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

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: const EdgeInsets.only(top: 50.0, left: 8, right: 8),
        decoration: BoxDecoration(color: Color(0xFFFAFAFF)),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: names.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Color(0xFF606060)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFDDDDDD)
                  ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 5)),
                        IconButton(onPressed: () {
                          Navigator.pushNamed(context, IntoChat.routeName);
                        },
                            icon: const Icon(Icons.chat_bubble_outline)),
                        Image.asset('assets/images/face2face.png'),
                        Padding(padding: EdgeInsets.only(left: 8)),
                        Text("${names[index]}", style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Roboto",
                            color: Color(0xFF000000))),
                        Expanded(child: Container()),
                        Text("${messages[index]}", style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Roboto",
                            color: Color(0xFF000000))),
                        Padding(padding: EdgeInsets.only(right: 8))
                      ]
                  )
              );
            }
        )
    );
  }
}

class IntoChat extends StatefulWidget {
  const IntoChat({Key? key})
      : super(key: key);

  static const String routeName = "/IntoChat";

  @override
  State<IntoChat> createState() => new SecondRoute();
}

class SecondRoute extends State<IntoChat> {
  @override
  Widget build(BuildContext context) {
    Widget _buildBody() {
      return Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: const EdgeInsets.only(top: 50.0, left: 8, right: 8),
          decoration: BoxDecoration(color: Color(0xFFFAFAFF)),
          child: Text(
            "hello",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF000000)
            ),
          )

      );

    }
    PreferredSizeWidget _buildAppBar() {
      return AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Name'),
        leading: IconButton(
          alignment: Alignment.centerLeft,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);// Respond to button press
          },
        ),
        actions: const <Widget>[],
      );
    }
    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppBar(),
    );
  }
}
/*class _ChatState extends State<ChatPage> {
  int _page = 0;
  int _chatIndex = 0;
  final List<String> names = <String>['Alex', 'Bob', 'Connor', "Dan"];
  final List<String> messages = <String>['I\'m gonna be late to class', 'Hello', 'I LOVE FISHIN', 'Hey girl'];

  @override
  Widget build(BuildContext context) {
    // This method is specific to the camera
    Widget _buildChat() {
      if(_page == 0) {
        return Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: const EdgeInsets.only(top: 50.0, left: 8, right: 8),
            decoration: BoxDecoration(color: Color(0xFFFAFAFF)),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: Color(0xFF606060)
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFFDDDDDD)
                      ),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 20,
                      child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 5)),
                            IconButton(onPressed: () {
                              setState(() {
                                _page = 1;
                                _chatIndex = index;
                              });
                            },
                                icon: const Icon(Icons.chat_bubble_outline)),
                            Image.asset('assets/images/face2face.png'),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Text("${names[index]}", style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Roboto",
                                color: Color(0xFF000000))),
                            Expanded(child: Container()),
                            Text("${messages[index]}", style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Roboto",
                                color: Color(0xFF000000))),
                            Padding(padding: EdgeInsets.only(right: 8))
                          ]
                      )
                  );
                }
            )
        );
      }
      else{  // Go into chat with other user
          return Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: const EdgeInsets.only(top: 50.0, left: 8, right: 8),
            decoration: BoxDecoration(color: Color(0xFFFAFAFF)),
            child: Row(
                children: [
                  IconButton(onPressed: () {
                    setState(() {
                      _page = 0;
                    });
                  },
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF000000),)),
                  Text(
                    "${names[_chatIndex]}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF000000)
                    ),
                  )
                ]
            )
          );
      }
    }
    return _buildChat();
  }
}*/
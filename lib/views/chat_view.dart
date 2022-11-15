import 'package:face2face/view_models/chatViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat.dart';

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
                        Text('${names[index]}', style: TextStyle(
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
  int _userIndex = 0;
  String _chatPerson = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> names = context.watch<ChatViewModel>().names;
    final List<List<chat>> allMsg = context.watch<ChatViewModel>().byName;
    final List<chat> messages = context.watch<ChatViewModel>().getNamedchats("Alex");
    //List<chat> getChatsPerUser() {
      //return messages.where((element) => element.senderName == _chatPerson).toList();
    //}
    
    AlignmentGeometry getAl(bool sentByMe){
      if(sentByMe)
        return Alignment.centerRight;
      else
        return Alignment.centerLeft;
    }
    
    Color? getColor(bool sentByMe){
      if(sentByMe)
        return Colors.blue[200];
      else
        return Colors.white;
    }
    
    CrossAxisAlignment getNameAl(bool sentByMe){
      if(sentByMe)
        return CrossAxisAlignment.end;
      else
        return CrossAxisAlignment.start;
    }

    Widget displayMessage(chat message){
      return Column(
          crossAxisAlignment: getNameAl(message.sentByMe),
          children: [
            Text("${message.senderName}"),
            Container(
                constraints: BoxConstraints(maxWidth: 200),
                decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(20), color: getColor(message.sentByMe)),
                padding: EdgeInsets.all(10),
                child: Text("${message.message}")
            )
          ]
      );
    }
    
    // This method builds the chat
    Widget _buildChat() {
      if(_page == 0) {
        return Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: const EdgeInsets.only(top: 50.0, left: 8, right: 8),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: allMsg.length,
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
                                _userIndex = index;
                              });
                            },
                                icon: const Icon(Icons.chat_bubble_outline)),
                            Image.asset('assets/images/face2face.png'),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Text("${allMsg[index][0].senderName}", style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Roboto",
                                color: Color(0xFF000000))),
                            Expanded(child: Container(constraints: BoxConstraints(minWidth: 50),)),
                            Flexible(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("${allMsg[index][allMsg[index].length-1].message}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Roboto",
                                      color: Color(0xFF000000),
                                  )
                              )),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8))
                          ]
                      )
                  );
                }
            )
        );
      }
      else{  // Go into chat with other user
          return Column(
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: const EdgeInsets.only(top: 50.0, left: 8, right: 8),
                  child: Row(
                      children: [
                        IconButton(onPressed: () {
                          setState(() {
                            _page = 0;
                          });
                        },
                            icon: const Icon(Icons.arrow_back, color: Color(0xFF000000),)),
                        Text(
                          "${names[_userIndex]}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF000000)
                          ),
                        )
                      ]
                  )
                ),

                //Message area
                Expanded(
                    flex: 5,
                    child: Container(
                      child: ListView.builder(
                        itemCount: allMsg[_userIndex].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Align(
                              alignment: getAl(allMsg[_userIndex][index].sentByMe),
                              child: displayMessage(allMsg[_userIndex][index]),
                          );
                        },
                      )
                    )),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              hintText: 'Message',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<ChatViewModel>().sendChat(chat(messageController.text,"Hailey",names[_userIndex],true));
                                messageController.text = "";
                              },
                              child: const Text('Send'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                Padding(padding: EdgeInsets.only(bottom: 50))
              ]
          );
      }
    }
    return _buildChat();
  }
}*/
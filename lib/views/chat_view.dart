import 'package:face2face/view_models/chatViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:face2face/palette.dart';
import '../models/chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
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
        return Palette.orchid[100];
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
                constraints: BoxConstraints(maxWidth: 250),
                decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(20), color: getColor(message.sentByMe)),
                padding: EdgeInsets.all(10),
                child: Text("${message.message}", style: TextStyle(fontSize: 20),)
            )
          ]
      );
    }

    // This method builds the chat
    Widget _buildChat() {
      if(_page == 0) {
        return Container(
            color: Palette.mauve[50],
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
                          color: Palette.orchid[100]
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
                  color: Palette.mauve[50],
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
                      color: Palette.mauve[50],
                      child: ListView.builder(
                        itemCount: allMsg[_userIndex].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Align(
                            alignment: getAl(allMsg[_userIndex][index].sentByMe),
                            child: Padding(child: displayMessage(allMsg[_userIndex][index]), padding: const EdgeInsets.only(left:10, right:10),),
                          );
                        },
                      )
                  )),
              Container(
                  child: Form(
                    key: _formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left:20)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: TextFormField(
                            cursorColor: Palette.orchid,
                            controller: messageController,
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.orchid)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.orchid, width: 2)),
                              suffixIconColor: Palette.pink,
                              hintText: 'Message',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Palette.orchid[500])),
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
}
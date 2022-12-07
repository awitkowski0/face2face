import 'package:face2face/view_models/chat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:face2face/palette/palette.dart';
import '../models/chat.dart';
import '../models/user.dart';
import '../view_models/users_viewmodel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
  int _page = 0;
  String _userIndex = "0";
  String _userLoggedIn = "0";
  List<UserAccount> users = [
    UserAccount(uniqueKey: "0", displayName: "Hailey"),
    UserAccount(uniqueKey: "1", displayName: "Alex"),
    UserAccount(uniqueKey: "2", displayName: "Matt"),
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Chat> allMsg = context.watch<ChatViewModel>().currUserChats;

    AlignmentGeometry getAl(int sender){
      if(sender == int.parse(_userLoggedIn))
        return Alignment.centerRight;
      else
        return Alignment.centerLeft;
    }

    Color? getColor(int sender){
      if(sender == int.parse(_userLoggedIn))
        return Palette.orchid[100];
      else
        return Colors.white;
    }

    CrossAxisAlignment getNameAl(int id){
      if(id == int.parse(_userLoggedIn))
        return CrossAxisAlignment.end;
      else
        return CrossAxisAlignment.start;
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
                                _userIndex = allMsg[index].user2ID;
                              });
                            },
                                icon: const Icon(Icons.chat_bubble_outline)),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Text("${users.firstWhere((element) => element.uniqueKey == allMsg[index].user2ID).displayName}", style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Roboto",
                                color: Color(0xFF000000))),
                            Expanded(child: Container(constraints: BoxConstraints(minWidth: 50),)),
                            Flexible(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${allMsg[index].messages![allMsg[index].messages!.length-1].message}",
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
                          "${users.firstWhere((element) => element.uniqueKey == allMsg.firstWhere((element) => element.user2ID == _userIndex).user2ID).displayName}",
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
                        itemCount: allMsg.firstWhere((element) => element.user2ID == _userIndex).messages!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Align(
                            alignment: getAl(allMsg.firstWhere((element) => element.user2ID == _userIndex).messages![index].senderID),
                            child: Padding(
                              child: Column(
                                  crossAxisAlignment: getNameAl(allMsg.firstWhere((element) => element.user2ID == _userIndex).messages![index].senderID),
                                  children: [
                                    Text("${users.firstWhere((element) => element.uniqueKey == "${allMsg.firstWhere((element) => element.user2ID == _userIndex).messages![index].senderID}").displayName}"),
                                    Container(
                                        constraints: BoxConstraints(maxWidth: 250),
                                        decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(20), color: getColor(allMsg.firstWhere((element) => element.user2ID == _userIndex).messages![index].senderID)),
                                        padding: EdgeInsets.all(10),
                                        child: Text("${allMsg.firstWhere((element) => element.user2ID == _userIndex).messages![index].message}", style: TextStyle(fontSize: 20),)
                                    )
                                  ]
                              ),
                              padding: const EdgeInsets.only(left:10, right:10),),
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
                              context.read<ChatViewModel>().sendChat(Message(int.parse(_userLoggedIn), int.parse(_userIndex), messageController.text, DateTime.now()), _userLoggedIn, _userIndex);
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



class Chat {
  List<Message> messages;
  String user1Name;
  String user2Name;

  Chat(this.messages, this.user1Name, this.user2Name);
}

class Message {
  int senderID;
  int receiverID;
  String message;
  DateTime time;

  Message(this.senderID, this.receiverID, this.message, this.time);
}
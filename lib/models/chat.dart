


class Chat {
  final List<Message>? messages;
  final String user1Name;
  final String user2Name;

  Chat(this.messages, this.user1Name, this.user2Name);

  factory Chat.fromJson(Map<String, dynamic> json) =>
      _chatFromJson(json);
  Map<String, dynamic> toJson() => _chatToJson(this);
}

class Message {
  int senderID;
  int receiverID;
  String message;
  DateTime time;

  Message(this.senderID, this.receiverID, this.message, this.time);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['senderID'] as int,
      json['receiverID'] as int,
      json['message'] as String,
      json['time'].toDate() as DateTime,
    );
  }
  Map<String, dynamic> toJson() => {
    'senderID': senderID,
    'receiverID': receiverID,
    'message': message,
    'time': time,
  };
}

Chat _chatFromJson(Map<String, dynamic> json) {
  return Chat(
    (json['messages'] as List<dynamic>)
        .map((dynamic e) => Message.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['user1Name'] as String,
    json['user2Name'] as String,
  );
}

Map<String, dynamic> _chatToJson(Chat chat) => {
  'messages': _messageList(chat.messages),
  'user1Name': chat.user1Name,
  'uesr2Name': chat.user2Name,
};

List<Map<String, dynamic>>? _messageList(List<Message>? messages) {
  if (messages == null) {
    return null;
  }
  final messageMap = <Map<String, dynamic>>[];
  for (var message in messages) {
    messageMap.add(message.toJson());
  }
  return messageMap;
}

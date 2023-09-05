import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  final String senderUserId;
  final String receiverUserId;
  final String message;
  final DateTime time;
  final String messageId;
  Message({
    required this.senderUserId,
    required this.receiverUserId,
    required this.message,
    required this.time,
    required this.messageId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderid': senderUserId,
      'receiverid': receiverUserId,
      'message': message,
      'time': time.millisecondsSinceEpoch,
      'msgid': messageId,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderUserId: map['senderid'] as String,
      receiverUserId: map['receiverid'] as String,
      message: map['message'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      messageId: map['msgid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(senderUserId: $senderUserId, receiverUserId: $receiverUserId, message: $message, time: $time, messageId: $messageId)';
  }
}

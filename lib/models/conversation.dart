// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Conversation {
  final String userId;
  final String lastMessageId;
  Conversation({
    required this.userId,
    required this.lastMessageId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userId,
      'lastmsgid': lastMessageId,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      userId: map['userid'] as String,
      lastMessageId: map['lastmsgid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Conversation(userId: $userId, lastMessageId: $lastMessageId)';
}

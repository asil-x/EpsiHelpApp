// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:epsihelp_app/models/message.dart';
import 'package:epsihelp_app/models/user.dart';

class Convs {
  final UserModel user;
  final Message message;
  Convs({
    required this.user,
    required this.message,
  });

  @override
  String toString() => 'Convs(user: $user, message: $message)';
}

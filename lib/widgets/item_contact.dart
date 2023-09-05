// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:epsihelp_app/controllers/authcontroller.dart';
import 'package:epsihelp_app/models/message.dart';
import 'package:epsihelp_app/models/user.dart';
import 'package:epsihelp_app/screens/chat_screen.dart';
import 'package:get/get.dart';

import '../colors.dart';

class ItemContactsList extends StatefulWidget {
  final UserModel user;
  final Message lastMessage;
  const ItemContactsList({
    Key? key,
    required this.user,
    required this.lastMessage,
  }) : super(key: key);
  @override
  State<ItemContactsList> createState() => _ItemContactsListState();
}

class _ItemContactsListState extends State<ItemContactsList> {
  late bool amIAdmin;
  late AuthController authCont;
  @override
  void initState() {
    authCont = Get.find<AuthController>();
    amIAdmin = authCont.user!.role == 'admin';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: kPurple,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          Get.to(() => ChatScreen(otherUser: widget.user));
        },
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 0,
        ),
        leading: CircleAvatar(
          backgroundColor: kGrey,
          backgroundImage: amIAdmin
              ? widget.user.photoUrl.isNotEmpty
                  ? NetworkImage(widget.user.photoUrl)
                  : null
              : authCont.admin!.photoUrl.isNotEmpty
                  ? NetworkImage(authCont.admin!.photoUrl)
                  : null,
          child: (amIAdmin
                  ? widget.user.photoUrl.isEmpty
                  : authCont.admin!.photoUrl.isEmpty)
              ? const Icon(Icons.person, color: Colors.black, size: 30)
              : null,
        ),
        title: Text(
          amIAdmin ? widget.user.NomPrenom : authCont.admin!.NomPrenom,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          widget.lastMessage.message,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${widget.lastMessage.time.hour}: ${widget.lastMessage.time.minute}",
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

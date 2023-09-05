import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:epsihelp_app/controllers/authcontroller.dart';
import 'package:epsihelp_app/controllers/messagecontroller.dart';
import 'package:epsihelp_app/models/message.dart';
import 'package:epsihelp_app/models/user.dart';
import 'package:epsihelp_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../layout_utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.otherUser});

  final UserModel otherUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late UserModel myself;
  @override
  void initState() {
    myself = Get.find<AuthController>().user!;
    super.initState();
  }

  bool amISender(Message msg) {
    return msg.senderUserId == myself.userId;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MessageController(otherUser: widget.otherUser),
        builder: (msgCont) {
          return Scaffold(
            appBar: MyAppBar(
              title: widget.otherUser.role != 'admin'
                  ? widget.otherUser.NomPrenom
                  : 'Admin',
              isImageOnline: true,
              imagePath: widget.otherUser.photoUrl,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  msgCont.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(color: kPurple),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            key: UniqueKey(),
                            controller: msgCont.scrollCont,
                            itemBuilder: (context, index) {
                              int i = msgCont.msgList.length - index - 1;
                              var msg = msgCont.msgList[i];
                              return BubbleSpecialOne(
                                tail: false,
                                text: ' ${msg.message} ',
                                textStyle: TextStyle(
                                  color: amISender(msg)
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                ),
                                color: amISender(msg) ? kPurple : kLightGrey,
                                isSender: amISender(msg),
                              );
                            },
                            itemCount: msgCont.msgList.length,
                          ),
                        ),
                  verticalMargin(10),
                  MessageTextField(
                      msgCont: msgCont, rcvrId: widget.otherUser.userId),
                ],
              ),
            ),
          );
        });
  }
}

class MessageTextField extends StatelessWidget {
  MessageTextField({super.key, required this.msgCont, required this.rcvrId});
  final MessageController msgCont;
  final String rcvrId;
  final txtCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: txtCont,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            if (txtCont.text.trim().isNotEmpty) {
              FocusScope.of(context).unfocus();
              msgCont.sendMessage(txtCont.text.trim(), rcvrId);
              txtCont.clear();
            }
          },
          icon: const Icon(Icons.send),
          color: kPurple,
        ),
        isDense: true,
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        enabledBorder: roundPurpleBorder(30),
        focusedBorder: roundPurpleBorder(30),
        hintText: "Enter your message here",
      ),
    );
  }
}

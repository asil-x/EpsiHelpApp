// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'package:epsihelp_app/controllers/authcontroller.dart';
import 'package:epsihelp_app/models/conversation.dart';
import 'package:epsihelp_app/models/message.dart';

import '../models/user.dart';

class MessageController extends GetxController {
  late final AuthController authCont;
  late final ScrollController scrollCont;

  RxBool isLoading = false.obs;
  RxList<Message> msgList = <Message>[].obs;
  late bool iAmNotAdmin;
  String convId = '';
  late bool hasConv;
  UserModel otherUser;
  MessageController({required this.otherUser});
  @override
  void onInit() {
    scrollCont = ScrollController(initialScrollOffset: 0.0);
    authCont = Get.find<AuthController>();
    iAmNotAdmin = authCont.user!.role != 'admin';
    subscribeIt();
    super.onInit();
  }

  void subscribeIt() async {
    hasConv = await convExists();
    var querySender = FirebaseFirestore.instance
        .collection('messages')
        .where('senderid',
            isEqualTo: iAmNotAdmin ? authCont.user!.userId : otherUser.userId)
        .snapshots();
    var queryReceiver = FirebaseFirestore.instance
        .collection('messages')
        .where('receiverid',
            isEqualTo: iAmNotAdmin ? authCont.user!.userId : otherUser.userId)
        .snapshots();

    querySender.listen((values) {
      log('Send Change in msg Collection');
      isLoading.value = true;
      for (var docX in values.docChanges) {
        msgList.add(Message.fromMap(docX.doc.data()!));
        msgList.sort((a, b) => a.time.compareTo(b.time));
        update();
      }
      isLoading.value = false;
    });
    queryReceiver.listen((values) {
      log('Receive Change in msg Collection');
      isLoading.value = true;
      for (var docX in values.docChanges) {
        msgList.add(Message.fromMap(docX.doc.data()!));
        msgList.sort((a, b) => a.time.compareTo(b.time));
        update();
      }
      isLoading.value = false;
    });
  }

  void sendMessage(String mesg, String recvrId) {
    var msg = Message(
      senderUserId: authCont.user!.userId,
      receiverUserId: recvrId,
      message: mesg,
      time: DateTime.now(),
      messageId: const Uuid().v1(),
    );
    FirebaseFirestore.instance
        .collection('messages')
        .add(msg.toMap())
        .whenComplete(() {
      if (hasConv) {
        var convF = Conversation(
            userId: iAmNotAdmin ? authCont.user!.userId : otherUser.userId,
            lastMessageId: msg.messageId);
        FirebaseFirestore.instance
            .collection('conversations')
            .doc(convId)
            .update(convF.toMap());
      }
      if (iAmNotAdmin && !hasConv) {
        Conversation convd = Conversation(
            userId: authCont.user!.userId, lastMessageId: msg.messageId);
        FirebaseFirestore.instance
            .collection('conversations')
            .add(convd.toMap())
            .then((value) {
          convId = value.id;
        });
        hasConv = true;
      }
    });
  }

  Future<bool> convExists() async {
    var v = await FirebaseFirestore.instance
        .collection('conversations')
        .where('userid',
            isEqualTo: iAmNotAdmin ? authCont.user!.userId : otherUser.userId)
        .limit(1)
        .get();
    if (v.docs.isNotEmpty) {
      convId = v.docs.first.id;
      return true;
    } else {
      log("Conversation doesn't exist");
      return false;
    }
  }
}

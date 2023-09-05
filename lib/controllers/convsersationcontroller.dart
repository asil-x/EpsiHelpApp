import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsihelp_app/controllers/authcontroller.dart';
import 'package:epsihelp_app/controllers/messagecontroller.dart';
import 'package:epsihelp_app/models/conversation.dart';
import 'package:epsihelp_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/convs.dart';

class ConversationsController extends GetxController {
  RxBool isLoading = false.obs;
  List<Convs> conversations = [];
  List<Convs> _convs = [];
  late AuthController authController;
  late MessageController msgCont;
  late TextEditingController filterSearchCont;

  @override
  void onInit() {
    filterSearchCont = TextEditingController();
    authController = Get.find<AuthController>();
    getConvos();
    super.onInit();
  }

  void getConvos() async {
    FirebaseFirestore.instance
        .collection('conversations')
        .snapshots()
        .listen((data) {
      manageConvData(data);
    });
  }

  void filterConvos() {
    var cc = _convs;
    conversations = cc
        .where((element) => element.user.NomPrenom
            .isCaseInsensitiveContains(filterSearchCont.text.trim()))
        .toList();
    update();
  }

  void clearFilterConvos() {
    conversations = _convs;
    filterSearchCont.clear();
    update();
  }

  Future<Convs> getUserAndMsg(String userId, String lastMessageId) async {
    Convs? ans;
    var data = await authController.getUser(userId);
    var data2 = await getMessageFromId(lastMessageId);
    ans = Convs(user: data!, message: data2!);
    return ans;
  }

  Future<Message?> getMessageFromId(String msgid) async {
    Message? message;
    var data = await FirebaseFirestore.instance
        .collection('messages')
        .where('msgid', isEqualTo: msgid)
        .limit(1)
        .get();
    if (data.docs.isNotEmpty) {
      log('got the message');
      message = Message.fromMap(data.docs.first.data());
    }
    return message;
  }

  Future<List<Conversation>> getUserConversation() async {
    isLoading.value = true;

    var data = await FirebaseFirestore.instance
        .collection('conversations')
        .where('userid', isEqualTo: authController.user!.userId)
        .get();

    var pureData = data.docs;
    List<Conversation> convs = [];
    if (pureData.isNotEmpty) {
      for (var elem in pureData) {
        convs.add(Conversation.fromMap(elem.data()));
      }
    }
    isLoading.value = false;

    return convs;
  }

  Future<List<Convs>> searchUsers(String name) async {
    var convs = conversations
        .where((element) => element.user.NomPrenom.contains(name))
        .toList();
    return convs;
  }

  void addToList(RxList<dynamic> list, dynamic val) {
    list.add(val);
    update();
  }

  void setConversations(List<Convs> convs) {
    conversations = convs;
    _convs = convs;
    update();
  }

  void resetConversations() {
    conversations = [];
    _convs = [];
    update();
  }

  void addConversation(Convs conv) {
    conversations.add(conv);
    conversations.sort((a, b) => b.message.time.compareTo(a.message.time));
    _convs = conversations;
    update();
  }

  void manageConvData(var data) async {
    isLoading.value = true;
    var pureData = data.docs;
    if (pureData.isNotEmpty) {
      resetConversations();
      for (var elem in pureData) {
        var convf = Conversation.fromMap(elem.data());
        var conv = await getUserAndMsg(convf.userId, convf.lastMessageId);
        addConversation(conv);
      }
      isLoading.value = false;
    }
  }
}

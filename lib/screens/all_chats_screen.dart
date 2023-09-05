import 'package:epsihelp_app/colors.dart';
import 'package:epsihelp_app/controllers/convsersationcontroller.dart';
import 'package:epsihelp_app/widgets/app_bar.dart';
import 'package:epsihelp_app/widgets/item_contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../layout_utils.dart';
// ignore: library_prefixes
import '../widgets/search_bar.dart' as MySearchBar;

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationsController>(
        init: ConversationsController(),
        builder: (convCont) {
          return Scaffold(
            appBar: const MyAppBar(title: "Messagerie"),
            body: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  const MySearchBar.SearchBar(),
                  verticalMargin(10),
                  Expanded(
                    child: convCont.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(color: kPurple),
                          )
                        : (convCont.conversations.isEmpty
                            ? const Center(
                                child: Text('No Conversations Found'),
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return ItemContactsList(
                                    user: convCont.conversations[index].user,
                                    lastMessage:
                                        convCont.conversations[index].message,
                                  );
                                },
                                itemCount: convCont.conversations.length,
                              )),
                  )
                ],
              ),
            ),
          );
        });
  }
}

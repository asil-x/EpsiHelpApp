import 'package:epsihelp_app/controllers/authcontroller.dart';
import 'package:epsihelp_app/controllers/faqcontroller.dart';
import 'package:epsihelp_app/models/faq.dart';
import 'package:epsihelp_app/screens/add_faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../colors.dart';

class ItemFAQ extends StatefulWidget {
  final FAQ faq;

  const ItemFAQ({super.key, required this.faq});

  @override
  State<ItemFAQ> createState() => _ItemFAQState();
}

class _ItemFAQState extends State<ItemFAQ> {
  bool showAnswer = false;
  late bool isAdmin;
  @override
  void initState() {
    isAdmin = Get.find<AuthController>().user!.role == 'admin';
    super.initState();
  }

  @override
  Widget build(BuildContext cont) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: kGrey,
          ),
          vertical: showAnswer
              ? BorderSide(
                  color: kGrey,
                )
              : BorderSide.none,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(
              left: 10,
            ),
            tileColor: kLightPurple,
            horizontalTitleGap: 0,
            leading: SvgPicture.asset("assets/images/ic_question.svg"),
            title: Text(
              widget.faq.question,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  showAnswer = !showAnswer;
                });
              },
              icon: Icon(showAnswer
                  ? Icons.keyboard_arrow_down_sharp
                  : Icons.keyboard_arrow_right_sharp),
            ),
          ),
          if (showAnswer)
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 20,
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.faq.answer,
                    ),
                  ),
                  isAdmin
                      ? PopupMenuButton<String>(
                          onSelected: (value) {
                            var cont = Get.find<FAQController>();
                            if (value == "Edit") {
                              Get.to(() => AddFaqScreen(faq: widget.faq));
                            } else if (value == "Delete") {
                              cont.deleteFAQFromFirebase(widget.faq);
                            }
                          },
                          itemBuilder: (_) => [
                                const PopupMenuItem<String>(
                                  value: "Edit",
                                  child: Text(
                                    "Edit",
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: "Delete",
                                  child: Text(
                                    "Delete",
                                  ),
                                ),
                              ])
                      : const SizedBox.shrink()
                ],
              ),
            )
        ],
      ),
    );
  }
}

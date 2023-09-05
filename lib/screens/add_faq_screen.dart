import 'package:epsihelp_app/controllers/faqcontroller.dart';
import 'package:epsihelp_app/widgets/app_bar.dart';
import 'package:epsihelp_app/widgets/round_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uuid/uuid.dart';

import '../layout_utils.dart';
import '../models/faq.dart';

class AddFaqScreen extends StatefulWidget {
  const AddFaqScreen({super.key, this.faq});

  final FAQ? faq;

  @override
  State<AddFaqScreen> createState() => _AddFaqScreenState();
}

class _AddFaqScreenState extends State<AddFaqScreen> {
  bool isEdit = false;
  String question = "";
  String answer = "";
  late FAQController controller;
  @override
  void initState() {
    if (widget.faq != null) {
      isEdit = true;
      question = widget.faq!.question;
      answer = widget.faq!.answer;
    }
    controller = Get.find<FAQController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgressHUD(
        inAsyncCall: controller.isLoading.value,
        child: Scaffold(
          appBar: MyAppBar(title: isEdit ? "Edit FAQ" : "Add FAQ"),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Question",
                  ),
                  verticalMargin(10),
                  TextFormField(
                    initialValue: question,
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: roundPurpleBorder(15),
                      focusedBorder: roundPurpleBorder(15),
                    ),
                    onChanged: (value) {
                      question = value;
                    },
                  ),
                  verticalMargin(30),
                  const Text(
                    "Answer",
                  ),
                  verticalMargin(10),
                  TextFormField(
                    initialValue: answer,
                    maxLines: 10,
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: roundPurpleBorder(15),
                      focusedBorder: roundPurpleBorder(15),
                    ),
                    onChanged: (value) {
                      answer = value;
                    },
                  ),
                  verticalMargin(30),
                  RoundCornerButton(
                    buttonText: isEdit ? "Save" : "Add",
                    onPressed: () async {
                      controller.isLoading.value = true;
                      if (question.trim() == "" || answer.trim() == "") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Please enter both values"),
                        ));
                        return;
                      }
                      if (!isEdit) {
                        FAQ faq = FAQ(
                          question: question,
                          answer: answer,
                          faqId: const Uuid().v1(),
                        );
                        controller.addFAQInFirebase(faq).then((value) {
                          controller.isLoading.value = false;
                          if (value) {
                            Get.back();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text("Failed to add FAQ"),
                            ));
                          }
                        });
                      } else {
                        FAQ faq = FAQ(
                            question: question,
                            answer: answer,
                            faqId: widget.faq!.faqId);
                        controller.saveFAQInFirebase(faq).then((value) {
                          controller.isLoading.value = false;
                          if (value) {
                            Get.back();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text("Failed to save FAQ"),
                            ));
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

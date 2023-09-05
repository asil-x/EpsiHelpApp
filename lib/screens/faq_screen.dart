import 'package:epsihelp_app/controllers/faqcontroller.dart';
import 'package:epsihelp_app/screens/add_faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../colors.dart';
import '../widgets/app_bar.dart';
import '../widgets/item_faq.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key, required this.isAdmin});
  final bool isAdmin;

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  //late FAQController faqCont;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FAQController>(
      init: FAQController(),
      builder: (faqCont) => ModalProgressHUD(
        inAsyncCall: faqCont.isLoading.value,
        child: Scaffold(
          appBar: MyAppBar(
            title: "FAQs",
            actions: [
              widget.isAdmin
                  ? FloatingActionButton.small(
                      backgroundColor: kPurple,
                      elevation: 0,
                      onPressed: () {
                        Get.to(() => const AddFaqScreen());
                      },
                      highlightElevation: 0,
                      child: const Icon(
                        Icons.add,
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                width: 8,
              )
            ],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: faqCont.faqs.isEmpty && !faqCont.isLoading.value
                ? const Center(
                    child: Text('No FAQs Found'),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return ItemFAQ(
                        faq: faqCont.faqs[index],
                      );
                    },
                    itemCount: faqCont.faqs.length,
                  ),
          ),
        ),
      ),
    );
  }
}

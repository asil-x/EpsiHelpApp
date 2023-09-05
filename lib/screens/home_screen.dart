import 'package:epsihelp_app/controllers/authcontroller.dart';
import 'package:epsihelp_app/screens/all_chats_screen.dart';
import 'package:epsihelp_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:epsihelp_app/screens/schedule_screen.dart';
import 'package:epsihelp_app/screens/faq_screen.dart';
import 'package:get/get.dart';
import '../widgets/square_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthController authCont;
  late bool isAdmin;
  @override
  void initState() {
    authCont = Get.find<AuthController>();
    isAdmin = authCont.user!.role == 'admin';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Image.asset("assets/images/icon.png"),
        title: const Text("BONJOUR"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset("assets/images/home_banner.png"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SquareButton(
                          onPressed: () {
                            Get.to(() => FaqScreen(isAdmin: isAdmin));
                          },
                          buttonText: "FAQs",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SquareButton(
                          onPressed: () {
                            Get.to(() => const ScheduleScreen());
                          },
                          buttonText: "EDT",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SquareButton(
                    onPressed: () {
                      if (isAdmin) {
                        Get.to(() => const AllChatsScreen());
                      } else {
                        Get.to(() => ChatScreen(otherUser: authCont.admin!));
                      }
                    },
                    buttonText: isAdmin ? "MESSAGERIE" : "CONTACTER",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:epsihelp_app/controllers/authcontroller.dart';
import 'package:epsihelp_app/screens/home_screen.dart';
import 'package:epsihelp_app/widgets/round_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../layout_utils.dart';
import '../widgets/round_centered_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController email;
  late final TextEditingController password;
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/home_banner.png"),
              verticalMargin(30),
              Text(
                "ESPACE ÉTUDIANT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: kPurple,
                ),
              ),
              verticalMargin(10),
              Get.find<AuthController>().isLoading.value
                  ? Center(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(color: kPurple),
                      ),
                    )
                  : const SizedBox(width: 30, height: 30),
              verticalMargin(20),
              RoundCenteredTextField("Email", (_) {}, email),
              verticalMargin(20),
              RoundCenteredTextField("Password", (_) {}, password),
              verticalMargin(20),
              RoundCornerButton(
                buttonText: "Login",
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (!email.text.trim().isEmail) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Email format invalid"),
                    ));
                    return;
                  }
                  if (email.text.isEmpty || password.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Please enter both values"),
                    ));
                    return;
                  }

                  Get.find<AuthController>()
                      .signIn(email.text.trim(), password.text.trim())
                      .then((value) {
                    if (value != null) {
                      Get.offAll(() => const HomeScreen());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text("Sign In failed"),
                      ));
                    }
                  });
                },
              )
            ],
          ),
        ),
      );
    });
  }
}

import 'dart:ffi';

import 'package:epsihelp_app/controllers/authcontroller.dart';
import 'package:epsihelp_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'colors.dart';
import 'firebase_options.dart';

Future<Void?> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  return null;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (context) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: kPurple,
              fontFamily: 'Poppins',
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 0,
                titleTextStyle: TextStyle(
                  color: kPurple,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
                // TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                backgroundColor: Colors.white,
                elevation: 0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
            ),
            home: const LoginScreen(),
          );
        });
  }
}

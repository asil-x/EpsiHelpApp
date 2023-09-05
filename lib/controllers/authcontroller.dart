import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:epsihelp_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  late RxBool isAuthenticated;
  late RxBool isLoading;
  UserModel? user;
  UserModel? admin;
  late final StreamSubscription streamSub;
  @override
  void onInit() {
    isAuthenticated = false.obs;
    isLoading = false.obs;
    streamSub = FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        isAuthenticated.value = true;
      } else {
        isAuthenticated.value = false;
      }
    });
    super.onInit();
  }

  Future<UserModel?> getUser(String userid) async {
    UserModel? usermodel;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: userid)
        .limit(1)
        .get();
    if (data.docs.isNotEmpty) {
      log('got the user');
      usermodel = UserModel.fromMap(data.docs.first.data());
    }
    return usermodel;
  }

  Future<UserCredential?> signIn(email, password) async {
    try {
      isLoading.value = true;
      var duser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (duser.user != null) {
        var userd = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: duser.user!.email)
            .get();
        if (userd.docs.isNotEmpty) {
          log('got the user');
          var data = userd.docs.first.data();
          user = UserModel(
            email: data['email'],
            userId: data['userid'],
            role: data['role'],
            NomPrenom: data['nometprenom'],
            photoUrl: data['photourl'],
          );
        }
        var admind = await FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'admin')
            .limit(1)
            .get();
        if (admind.docs.isNotEmpty) {
          log('got the admin');
          var data = admind.docs.first.data();
          admin = UserModel(
            email: data['email'],
            userId: data['userid'],
            role: data['role'],
            NomPrenom: data['nometprenom'],
            photoUrl: data['photourl'],
          );
        }
        isLoading.value = false;
        return duser;
      }
    } catch (e) {
      isLoading.value = false;
      log('Exception here: $e');
    }
    return null;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/core/services/auth_service.dart';
import 'package:gym_power/views/control_view.dart';

class AuthViewModel extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  String? email, password, confirmPassword, username;
  bool stateIsError = false;

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Rx<User?> _user = Rx<User?>(null);
  Rx<User?> get currentuser => _user;
  String? get user => _user.value?.email;

  bool isButtonEnabled = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {}
  }

  void createaccountwithemailandpassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((user) async {
        print("object");
        await user.user!.updateDisplayName(username);
        Get.offAll(ControlView());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void signinwithEmailAndPassword() async {
    try {
      await AuthService.signIn(email!, password!).then((value) async {
        Get.offAll(ControlView());
      });
    } catch (e) {}
  }

  void signOut() async {
    await AuthService.signOut();
  }
}

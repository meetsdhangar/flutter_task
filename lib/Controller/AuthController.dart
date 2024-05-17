import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/Screen/HomeScreen.dart';
import 'package:flutter_task/Screen/Login/SignUp/SignUpScreen.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authservice/firebasefunction.dart';

class AuthController extends GetxController {
  RxBool login = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // Signup User function
  signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await MyController.saveUser(name, email, userCredential.user!.uid);

      scaffoldMessengerKey.currentState
          ?.showSnackBar(SnackBar(content: Text('Registration Successful')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
      Get.offAll(HomeScreen());
    } catch (e) {
      scaffoldMessengerKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // Signin User function
  signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Get.offAll(() => HomeScreen());

      scaffoldMessengerKey.currentState
          ?.showSnackBar(SnackBar(content: Text('You are Logged in')));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid credentials')));
    }
  }

  // Google sign-in function
  googlesignIn() async {
    GoogleAuthProvider gprovider = GoogleAuthProvider();
    final data = await auth.signInWithProvider(gprovider);
    final sp = await SharedPreferences.getInstance();
    sp.setBool('googlelogin', true);
    Get.offAll(HomeScreen());
    return data;
  }

  // Google sign-out function
  Future<void> signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // Sign out from Google
      await googleSignIn.signOut();

      // Sign out from Firebase
      return await auth
          .signOut()
          .then((value) => Get.offAll(() => SignUpScreen()));
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/Controller/Authservice/firebasefunction.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logincontroller = Get.put((MyController()));
    Timer(Duration(seconds: 3), () {
      logincontroller.checkuserlogin();
    });
    return Scaffold(
        backgroundColor: Colors.purple,
        body: Center(
          child: Text(
            "Flutter Task",
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ));
  }
}

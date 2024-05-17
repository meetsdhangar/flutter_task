import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  final task;
  const DetailsScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text("All Details",
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 110, 178, 227),
              ),
              height: 320.h,
              width: 350.w,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Title :- ${task.title}",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Description :- ${task.description}",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Deadline :- ${task.deadline}",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Task Duration :- ${task.taskDuration},",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Completion Status :- ${task.status}",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_task/Models/homeModel.dart';
import 'package:flutter_task/Screen/HomeScreen.dart';
import 'package:flutter_task/Screen/Login/SignUp/LoginScreen.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  static saveUser(String name, email, uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set({'email': email, 'name': name});
  }

  addTask(String Title, String Description, String Deadline,
      String TaskDuration, String Status) async {
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final task = TaskModel(
        title: Title,
        description: Description,
        deadline: Deadline,
        taskDuration: TaskDuration,
        status: Status,
        createdat: time);
    // final ref = '';

    final ref = firestore.collection("tasks/${auth.currentUser!.email}/task/");

    await ref.doc(time).set(task.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> gettask() {
    return firestore
        .collection("tasks/${auth.currentUser!.email}/task/")
        .snapshots();
  }

  Future<void> deletetask(TaskModel task) async {
    final path = 'tasks/${auth.currentUser!.email}/task/${task.createdat}/';

    await FirebaseFirestore.instance.doc(path).delete().then((_) {
      print("Document successfully deleted!");
    }).catchError((error) {
      print("Error deleting document: $error");
    });
  }

  updatetask(
    creteat,
    title,
    taskDuration,
    description,
  ) async {
    await firestore
        .collection('tasks')
        .doc('${auth.currentUser?.email}/task/${creteat}/')
        .update({
      'title': title,
      "taskDuration": taskDuration,
      'description': description,
    }).then((value) => gettask());
  }

//mange user login
  checkuserlogin() {
    var user = auth.currentUser;

    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      checkuser().then((value) => Get.offAll(() => HomeScreen()));
    }
  }

//check user exist or not in firebase
  Future<bool> checkuser() async {
    return (await firestore
            .collection('users')
            .doc('${auth.currentUser?.email}')
            .get())
        .exists;
  }
}

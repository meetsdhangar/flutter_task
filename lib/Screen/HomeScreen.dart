import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_task/Controller/Authservice/firebasefunction.dart';
import 'package:flutter_task/Models/homeModel.dart';
import 'package:flutter_task/Screen/DetailsScreen.dart';
import 'package:get/get.dart';

import '../Controller/AuthController.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final fcontroller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    List<TaskModel> task = [];
    final authcontroller = Get.put(AuthController());
    final mycontroller = Get.put(MyController());
    final titlecontroller = TextEditingController();
    final descriptioncontroller = TextEditingController();
    final deadlinecontroller = TextEditingController();
    final durationcontroller = TextEditingController();
    final statuecontroller = TextEditingController();

    print(authcontroller.auth.currentUser);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              backgroundColor: Colors.purple,
              centerTitle: true,
              title: Text(
                "Task",
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      authcontroller.signOutGoogle();
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(hintText: "Title"),
                          controller: titlecontroller,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Description"),
                          controller: descriptioncontroller,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Deadline"),
                          controller: deadlinecontroller,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "TaskDuration"),
                          controller: durationcontroller,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Status"),
                          controller: statuecontroller,
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            titlecontroller.text;
                            descriptioncontroller.text;
                            deadlinecontroller.text;
                            durationcontroller.text;
                            statuecontroller.text;
                            if (titlecontroller.text.isNotEmpty &&
                                descriptioncontroller.text.isNotEmpty &&
                                deadlinecontroller.text.isNotEmpty &&
                                durationcontroller.text.isNotEmpty &&
                                statuecontroller.text.isNotEmpty) {
                              mycontroller.addTask(
                                  titlecontroller.text,
                                  descriptioncontroller.text,
                                  deadlinecontroller.text,
                                  durationcontroller.text,
                                  statuecontroller.text);
                            } else {
                              Get.snackbar("Error", "All Fileds Are Require");
                            }

                            Navigator.pop(context);
                            titlecontroller.clear();
                            descriptioncontroller.clear();
                            deadlinecontroller.clear();
                            durationcontroller.clear();
                            statuecontroller.clear();
                          },
                          child: Text('Add')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            titlecontroller.clear();
                            descriptioncontroller.clear();
                            deadlinecontroller.clear();
                            durationcontroller.clear();
                            statuecontroller.clear();
                          },
                          child: Text('Cancel'))
                    ],
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    child: StreamBuilder(
                        stream: mycontroller.gettask(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data?.docs;
                            task = data
                                    ?.map((e) => TaskModel.fromMap(e.data()))
                                    .toList() ??
                                [];
                          }
                          return ListView.builder(
                            itemCount: task.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: index % 2 == 0
                                        ? Color.fromARGB(255, 110, 178, 227)
                                        : Color.fromARGB(255, 232, 225, 163),
                                  ),
                                  width: 250.w,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task[index].title,
                                          style: TextStyle(
                                              fontSize: 20.h,
                                              color: index % 2 == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          task[index].description,
                                          style: TextStyle(
                                              fontSize: 15.h,
                                              color: index % 2 == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          task[index].status,
                                          style: TextStyle(
                                              fontSize: 15.h,
                                              color: index % 2 == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => DetailsScreen(
                                                task: task[index]));
                                          },
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "Show Details",
                                                style: TextStyle(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: index % 2 == 0
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: index % 2 == 0
                                                    ? Colors.white
                                                    : Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 40.h,
                                            width: double.infinity.w,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                  StreamBuilder(
                    stream: mycontroller.gettask(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data?.docs;
                        task = data
                                ?.map((e) => TaskModel.fromMap(e.data()))
                                .toList() ??
                            [];
                      }
                      return ListView.builder(
                        itemCount: task.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            child: ListTile(
                              title: Text(task[index].title.toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        mycontroller.deletetask(task[index]);
                                      },
                                      child: Icon(Icons.delete)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              titlecontroller.text =
                                                  task[index].title;
                                              descriptioncontroller.text =
                                                  task[index].description;
                                              deadlinecontroller.text =
                                                  task[index].deadline;
                                              durationcontroller.text =
                                                  task[index].taskDuration;
                                              statuecontroller.text =
                                                  task[index].status;

                                              return AlertDialog(
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text("Title"),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Title"),
                                                        controller:
                                                            titlecontroller,
                                                      ),
                                                      Text("Description"),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Description"),
                                                        controller:
                                                            descriptioncontroller,
                                                      ),
                                                      Text('Deadline'),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Deadline"),
                                                        controller:
                                                            deadlinecontroller,
                                                      ),
                                                      Text('TaskDuration'),
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                "TaskDuration"),
                                                        controller:
                                                            durationcontroller,
                                                      ),
                                                      Text('Status'),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Status"),
                                                        controller:
                                                            statuecontroller,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        mycontroller.updatetask(
                                                            task[index]
                                                                .createdat,
                                                            titlecontroller
                                                                .text,
                                                            durationcontroller
                                                                .text,
                                                            descriptioncontroller
                                                                .text);

                                                        Navigator.pop(context);
                                                        titlecontroller.clear();
                                                        descriptioncontroller
                                                            .clear();
                                                        deadlinecontroller
                                                            .clear();
                                                        durationcontroller
                                                            .clear();
                                                        statuecontroller
                                                            .clear();
                                                      },
                                                      child: Text('Edit')),
                                                  TextButton(
                                                      onPressed: () {
                                                        titlecontroller.clear();
                                                        descriptioncontroller
                                                            .clear();
                                                        deadlinecontroller
                                                            .clear();
                                                        durationcontroller
                                                            .clear();
                                                        statuecontroller
                                                            .clear();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel'))
                                                ],
                                              );
                                            });
                                      },
                                      child: Icon(Icons.edit))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            )));
  }
}

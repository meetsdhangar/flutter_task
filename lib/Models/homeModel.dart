// To parse this JSON data, do
//
//     final chatUser = chatUserFromMap(jsonString);

import 'dart:convert';

TaskModel homeModelFromMap(String str) => TaskModel.fromMap(json.decode(str));

String homeModelToMap(TaskModel data) => json.encode(data.toMap());

class TaskModel {
  String title;
  String description;
  String deadline;
  String taskDuration;
  String status;
  String createdat;

  TaskModel({
    required this.title,
    required this.description,
    required this.deadline,
    required this.taskDuration,
    required this.status,
    required this.createdat,
  });

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
      title: json["title"],
      description: json["description"],
      deadline: json["deadline"],
      taskDuration: json["taskDuration"],
      status: json["status"],
      createdat: json['createdat']);

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "deadline": deadline,
        "taskDuration": taskDuration,
        "status": status,
        'createdat': createdat,
      };
}

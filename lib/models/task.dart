import 'package:flutter/material.dart';



class Task {

  IconData?iconData;
  String?title;
  Color?bgColor;
  Color?iconColor;
  Color?btnColor;
  num?duration;
  bool?isLast;

  Task(
      {this.title, this.iconData, this.iconColor, this.bgColor, this.btnColor, this.duration, this.isLast = false});
  static List<Task>generateTasks(){
    return [
      Task(
          title: "Work",
          bgColor: Colors.redAccent,
          iconColor: Colors.red,
          iconData: Icons.food_bank,
          duration: 100

      ),
      Task(
          title: "Life",
          bgColor: Colors.yellowAccent,
          iconColor: Colors.yellow,
          iconData: Icons.food_bank,
          duration: 100

      ),
      Task(
          title: "Break",
          bgColor: Colors.blueAccent,
          iconColor: Colors.blue,
          iconData: Icons.food_bank,
          duration: 100

      ),
      Task(isLast: true)
    ];
  }
}




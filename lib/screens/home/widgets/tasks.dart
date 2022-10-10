import "package:flutter/material.dart";

import '../../../models/task.dart';
import '../../detail/detail.dart';

class Tasks extends StatelessWidget{
  final tasksList = Task.generateTasks();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        itemCount: tasksList.length,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) =>  _buildTask(context,tasksList[index])


      )
    );


  }


 Widget _buildTask(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () =>
       Navigator.push(context,
       MaterialPageRoute(builder: (context) => DetailPage(task: task))),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Icon(task.iconData, color: task.iconColor, size: 35),
         SizedBox(height: 30),
         Text(task.title.toString(), style: TextStyle(color: Colors.grey[800], fontSize: 18, fontWeight: FontWeight.bold)),
         SizedBox(height: 20),
         Row(
          children: [
            _buildTaskStatus(task.btnColor!, task.iconColor!, '${task.left} mins'),
            SizedBox(width: 5),

          ]
         )
        ]
      )
    );
 }

 Widget _buildTaskStatus(Color bgColor, Color txColor, String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text, style: TextStyle(color: txColor, fontSize: 16, fontWeight: FontWeight.bold)),
  );


 }
}
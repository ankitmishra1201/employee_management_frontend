import 'dart:convert';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/task.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/constants.dart';
import '../../detail/detail.dart';
import 'package:http/http.dart' as http;

class Tasks extends StatefulWidget{



  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  var _postdata=[];
  void getUserTask() async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');


      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.get(
        Uri.parse('${Constants.uri}/task'),
        headers: <String, String>{
          //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNDE3M2RhYmJmZjBiZTIyYTRkMzQ2MyIsImlhdCI6MTY2NTM3NTIxMH0.panoNVbulU2sdQGIHZhv2GYxZrstsVMEbf8f6M6iqwo
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNDM4ZGFlZmY2YTRhODU0OWY5NzY0YSIsImlhdCI6MTY2NTQwNDY1MH0.XxLG-vy8Bm_e8UN4-KO7-lw1ae4DlSSy3jl5rPHjLWk'
        },
      );

      var response = jsonDecode(tokenRes.body) as List;
      setState(() {
        _postdata = response;
      });

    } catch (e) {
      print(e);
      //showSnackBar(context, e.toString());
    }
  }
  final tasksList = Task.generateTasks();

  @override
  void initState() {

    super.initState();
    getUserTask();
  }

  @override
  Widget build(BuildContext context) {
    getUserTask();
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
    getUserTask();
    int count=0;
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
            _buildTaskStatus(task.btnColor!, task.iconColor!, 'nos ${task.left} '),
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
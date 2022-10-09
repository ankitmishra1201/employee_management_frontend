import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../models/task.dart';

class Tasks_info extends StatefulWidget {
  const Tasks_info({super.key});

  @override
  State<Tasks_info> createState() => _Tasks_infoState();
}

class _Tasks_infoState extends State<Tasks_info> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final tasklist=Task.generateTasks();

    return Container(
        child: Container(
      child: GridView.builder(

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
        ),
       itemBuilder:(context,index)=>_buildTask(context, tasklist[index]),
        itemCount: tasklist.length,

      ),

    ));



  }
}

Widget _buildTask(BuildContext context,Task task){
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: task.bgColor,
      borderRadius: BorderRadius.circular(20),
    ),
  );

}
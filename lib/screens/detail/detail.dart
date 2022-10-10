import "package:flutter/material.dart";
import 'package:task_app/screens/detail/widgets/date_picker.dart';
import 'package:task_app/screens/detail/widgets/task_title.dart';

import '../../models/task.dart';


class DetailPage extends StatelessWidget {
  final Task task;
  DetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    var detailList = task.desc;
    return Scaffold (
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                 color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 DatePicker(),
                 TaskTitle()

                ],
              ),
            ),
          ),

         // detailList = false ?
          // SliverFillRemaining(
          //   child: Container(
          //     color: Colors.white,
          //   child: Center(child: Text("No task today", style: TextStyle(color: Colors.grey, fontSize: 18)) )):
          //   SliverList(
          //     delegate: SliverChildBuilderDelegate(_, index )=> TaskTimeline(detailList[index]),
          //     childCount: detailList.length,
          //   ),
          //   )


        //],
      //),
    ],
      ),
      );
    
  }

  Widget _buildAppBar(BuildContext context) {
     return SliverAppBar(
       expandedHeight: 90,
       backgroundColor: Colors.black,
       leading: IconButton(
         icon: Icon(Icons.arrow_back_ios, color: Colors.white), iconSize: 20,
         onPressed: () => Navigator.pop(context),
       ),
       actions: [
         IconButton(
           icon: Icon(Icons.more_vert, color: Colors.white), iconSize: 40,
           onPressed: () {},
         ),
       ],
       flexibleSpace: FlexibleSpaceBar(
        title : Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${task.title} tasks', 
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('${task.left} tasks left for today', style: TextStyle(
              fontSize: 12, color: Colors.grey[700])),
          ]
        )
       ),
     );
  }
}
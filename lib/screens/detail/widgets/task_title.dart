import "package:flutter/material.dart";

class TaskTitle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[  Text('Tasks',
      style: TextStyle(
        color: Colors.grey[800],
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        
        child: Row(
        children: [
          Text("Timeline", style: TextStyle(color: Colors.grey[700], fontSize: 16)),
          Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey[700],),
          SizedBox(width: 10),
          
        ],
      ),
      ),
      ]
      ),
      );
      
  }
}
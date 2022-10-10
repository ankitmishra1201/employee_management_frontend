import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Task {
  IconData? iconData;
  String? title;
  Color? bgColor;
  Color? iconColor;
  Color? btnColor;
  num? left;
  num? done;
  List<Map<String, dynamic>>? desc;

  Task({this.iconData, this.title, this.bgColor, this.iconColor, this.btnColor, this.left, this.done,  this.desc});
  static List<Task> generateTasks() {
    return [
      
      Task(iconData: Icons.person_rounded,
      title: 'Meeting',
      bgColor: kYellowLight,
      iconColor: kYellowDark,
      btnColor: kYellow,
      left: 3,
      done: 2,
      desc: [
        {
          'time': '9:00 am',
          'title': 'Go for a walk with dog',
          'slot': '9:00 am - 10:00 am',
          'tlcolor': kRedDark,
          'bgColor': kRedLight,
          },
           {
          'time': '10:00 am',
          'title': 'Shot on Dribble',
          'slot': '10:00 am - 12:00 am',
          'tlcolor': kBlueDark,
          'bgColor': kBlueLight,
          },
          {
          'time': '11:00 am',
          'title': '',
          'slot': '',
          'tlcolor': kBlueDark,
          },
          {
            'time': '11:00 am',
          'title': '',
          'slot': '',
          'tlcolor': Colors.grey.withOpacity(0.3),
          },
           {
            'time': '1:00 pm',
          'title': 'Call with client ',
          'slot': '1:00 - 2:00 pm',
          'tlcolor': kYellowDark,
          'bgColor': kYellowLight,
          },
             {
          'time': '2:00 pm',
          'title': '',
          'slot': '',
          'tlcolor': Colors.grey.withOpacity(0.3),
          },
          {
            'time': '3:00 pm',
          'title': '',
          'slot': '',
          'tlcolor': Colors.grey.withOpacity(0.3),
          },

      ]
      ),
      Task(iconData: Icons.cases_rounded,
      title: 'Work',
      bgColor: kRedLight,
      iconColor: kRedDark,
      btnColor: kRed,
      left: 0,

      ),
      Task(iconData: Icons.favorite_rounded,
      title: 'Break',
      bgColor: kBlueLight,
      iconColor: kBlueDark,
      btnColor: kBlue,
      left: 3,

      ),

    ];
  }
}
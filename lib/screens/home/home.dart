import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:task_app/screens/home/widgets/tasks.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../providers/user_provider.dart';
import 'package:task_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/utils/constants.dart';
import 'dart:convert';
import '../../utils/events.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

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



  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = DateTime.now();
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  var _postdata = [];





  ///DATA MAPPING PIE CHART
  Map<String, double> dataMap = {
    "Flutter": 30,
    "React": 40,
    "Xamarin": 2,
    "Ionic": 2,
  };

  final List<ChartData> chartData = [
    ChartData('China', 12, 10, 14, 20),
    ChartData('USA', 14, 11, 18, 23),
    ChartData('UK', 16, 10, 15, 20),
    ChartData('Brazil', 18, 16, 18, 24)
  ];
  @override
  void initState(){
    super.initState();
    getUserTask();

  }

  @override
  Widget build(BuildContext context) {
   getUserTask();
    int totalduration = 0;
    final user = Provider.of<UserProvider>(context).user;
    final AuthService authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (user.role != "ADMIN")
                ? Text('Hi ' + user.name.toString() + '!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold))
                : Text(user.name.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black, size: 40),
            onPressed: () => authService.signOut(context),
          ),
        ],
      ),
      // ignore: dead_code

      // ignore: unused_label
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// BAR GRAPH AND PIE CHART

          Expanded(
            child: PageView(
              children: [
                Center(
                  child: PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 0,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 40,
                  ),
                ),
                SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries>[
                      ColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y3),
                      ColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y1),
                      ColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y2)
                    ])
              ],
            ),
          ),

          ///TITLE
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              'Tasks',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// TASKS CARD

          //Expanded(child: Tasks()),

          ///Calender
          Expanded(
            child: TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: CalendarFormat.week,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),

          ///List of Events
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var task = _postdata[index];
              return Card(
                color: (task["type"]=="WORK")?Colors.red:Colors.blueAccent,
                elevation: 3,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text(task['title']),
                    Text(task['description'])],
                ),
              );
            },
            itemCount: _postdata.length,
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
}

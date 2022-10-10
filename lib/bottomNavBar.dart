import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/user_provider.dart';
import 'package:task_app/screens/Profile/viewProfile.dart';
import 'package:task_app/screens/home/home.dart';
import 'package:task_app/screens/home/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/utils/constants.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
class bottomNavBar extends StatefulWidget {
  const bottomNavBar({Key? key}) : super(key: key);

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  int currentIndex = 0;
  final _screens = [
    HomePage(),
    ProfilePage()
  ];

  void _onitemtap(int index){
    setState(() {
      currentIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {


    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation:(user.role!="ADMIN")?FloatingActionButtonLocation.centerDocked:null,
      floatingActionButton:(user.role!="ADMIN")? _buildFloatingActionButton(context):null,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap:  _onitemtap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      elevation: 0.0,
      items: [Icons.home_filled, Icons.person]
          .asMap()
          .map((key, value) => MapEntry(
        key,
        BottomNavigationBarItem(
          label: " ",

          icon: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: currentIndex == key
                  ? Colors.blue[600]
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Icon(value),
          ),
        ),
      ))
          .values
          .toList(),
    );
  }


  Widget _buildFloatingActionButton(context) {
    return FloatingActionButton(
      enableFeedback: true,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),

      ),
      elevation: 0,

      backgroundColor: Colors.black,
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context){


              TextEditingController titlecontroller=TextEditingController();
              TextEditingController descriptioncontroller=TextEditingController();
              TextEditingController startdatecontroller=TextEditingController();
              TextEditingController enddatecontroller=TextEditingController();

              String ?dropdownValue;

              void postTask()async{
                try{
                http.Response res = await http.post(

                  Uri.parse('${Constants.uri}/signin'),
                  body: jsonEncode({
                    'title': titlecontroller.text,
                    'description': descriptioncontroller.text,
                    'type':dropdownValue.toString(),
                    'start_time':startdatecontroller.text,
                    'end_time':enddatecontroller.text

                  }),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization':'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImVtcGxveWVlQGdtYWlsLmNvbSIsImlkIjoiNjM0MzhkYWVmZjZhNGE4NTQ5Zjk3NjRhIiwiaWF0IjoxNjY1MzcxNTY2fQ.9InNUaNcfJ9pv5w_bxPSE37ys8ikgHbFH2No7It9kgU'
                  },
                );
                if(res.statusCode==200){
                  print("Great Success");
                }

                }catch(err){
                  print(err);
                }

              }

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [

                      Text("Add Task",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 30),),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                          controller: titlecontroller,
                          hintText: 'Enter your Title',
                          maxlines: 1,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(

                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                          controller: descriptioncontroller,
                          hintText: "Enter Description",
                          maxlines: 4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButton(
                        value: dropdownValue,
                          elevation: 0,



                          items: <String>["Hello","World","Meow"]
                              .map<DropdownMenuItem<String>>( (String value){
                            return DropdownMenuItem(
                                value: value,
                                child: Text(value)
                            );
                          }).toList(),
                          onChanged: (String? newValue){
                            setState(() {
                              dropdownValue=newValue!;
                            });
                          }
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        dateMask: 'd MMM, yyyy',
                        dateLabelText: "Enter Start Date & Time",

                        firstDate: DateTime(2022),
                        lastDate: DateTime.now(),
                        icon: Icon(Icons.event),
                        controller: startdatecontroller,
                      ),
                      const SizedBox(height: 20),
                      DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        dateMask: 'd MMM, yyyy',
                        dateLabelText: "Enter Start Date & Time",

                        firstDate: DateTime(2022),
                        lastDate: DateTime.now(),
                        icon: Icon(Icons.event),
                        controller: enddatecontroller,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(onPressed: ()=>postTask(), child: Text('Submit'))

                    ],
                  ),



                ),
              );

            });
      },
      child: Icon(Icons.add),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/screens/Admin/views/user_form.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import 'dart:convert';


class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  var _postdata=[];
    void getUser() async {
      try {
        var user = Provider.of<UserProvider>(context, listen: false);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token');

        if (token == null) {
          prefs.setString('x-auth-token', '');
        }

        var tokenRes = await http.get(
          Uri.parse('${Constants.uri}/getallusers'),
          // headers: <String, String>{
          //   //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNDE3M2RhYmJmZjBiZTIyYTRkMzQ2MyIsImlhdCI6MTY2NTM3NTIxMH0.panoNVbulU2sdQGIHZhv2GYxZrstsVMEbf8f6M6iqwo
          //   'Content-Type': 'application/json; charset=UTF-8',
          //   'Accept': 'application/json',
          //   'Authorization': 'Bearer ${token}'
          // },
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
    void initState(){
      super.initState();
      getUser();
    }


  @override
  Widget build(BuildContext context) {
      getUser();
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(

            itemBuilder: (context,index){
              var user=_postdata[index];
              return Padding(
                padding: EdgeInsets.all(50),
                child: GestureDetector(
                  onTap: null,
                  child: Container(

                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),

                    child: Center(
                      child: Text(user['name'].toString()),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder:(context,index){
              return SizedBox(
              height: 20,
              );
      },
            itemCount: _postdata.length
      ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginForm())),
        child: Icon(Icons.add),
      )
    );
  }
}

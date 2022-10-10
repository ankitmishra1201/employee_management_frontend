import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:task_app/bottomNavBar.dart';
import 'package:task_app/screens/Admin/UserList.dart';
import 'package:task_app/screens/login/components/login_form.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/home/home.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String department,
    required int contactno,
    required String name,
    required String dateofjoin,
    required String role,
    required String token,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          email: email,
          token: token,
          contactno: contactno,
          department: department,
          dateofjoin: dateofjoin,
          role: role
      );

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print(res.body);
          userProvider.setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => (jsonDecode(res.body)['role']=="NORMAL")?bottomNavBar():UserList(),
            ),
                (route) => false,
          );
        },
      );
    } catch (e) {

      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(
      BuildContext context,
      ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${Constants.uri}/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('${Constants.uri}/'),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': token},
        );

        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushReplacement(MaterialPageRoute(builder: (context)=>LoginForm())

    );
  }

}



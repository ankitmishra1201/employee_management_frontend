import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_app/bottomNavBar.dart';
import 'package:task_app/providers/user_provider.dart';
import 'package:task_app/screens/home/home.dart';
import 'package:task_app/screens/login/login_screen.dart';

import 'consants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child:MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Management App',

      home: Provider.of<UserProvider>(context).user.token.isEmpty ? const LoginScreen() : bottomNavBar(),
    );
  }
}

import 'package:date_time_picker/date_time_picker.dart';

import '../../../consants.dart';
import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController namecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController rolecontroller=TextEditingController();
  TextEditingController dateofjoin=TextEditingController();
  TextEditingController departmentcontroller=TextEditingController();
  TextEditingController contactcontroller=TextEditingController();

  final AuthService authService=AuthService();

  void signupUser() {
    authService.signUpUser(
      context: context,
      email: emailcontroller.text,
      password: passwordcontroller.text,
      contactno: 56756768469,
      name:namecontroller.text,
      department: departmentcontroller.text,
      dateofjoin: dateofjoin.text,
      role: rolecontroller.text ,



    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child: Form(
      child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: namecontroller,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,

                  decoration: const InputDecoration(
                    hintText: " Name",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (email) {},
                  decoration: const InputDecoration(
                    hintText: " email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.mail),
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: contactcontroller,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,

                  decoration: const InputDecoration(
                    hintText: " Contact Number",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.phone),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: passwordcontroller,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: " password",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),

                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: departmentcontroller,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,

                  decoration: const InputDecoration(
                    hintText: " Department",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.work),
                    ),
                  ),
                ),
                DateTimePicker(
                  type: DateTimePickerType.dateTime,
                  dateMask: 'd MMM, yyyy',
                  dateLabelText: "Enter Start Date & Time",

                  firstDate: DateTime(2022),
                  lastDate: DateTime.now(),
                  icon: Icon(Icons.event),
                  controller: dateofjoin,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: rolecontroller,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,

                  decoration: const InputDecoration(
                    hintText: " Role(ADMIN/NORMAL)",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.admin_panel_settings),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Hero(
                  tag: "login_btn",
                  child: ElevatedButton(
                    onPressed: (){
                      signupUser();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "ADD USER".toUpperCase(),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),

              ],
            ),
          ),
      ),
          ),
        ),
    );
  }
}
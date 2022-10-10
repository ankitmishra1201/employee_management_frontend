// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/screens/Admin/models/user.dart';
import 'package:task_app/screens/Admin/providers/users.dart';
class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['function'] = user.function;
    _formData['urlAvatar'] = user.urlAvatar;
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    if (user != null && user.id != null) {
      _loadFormData(user);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Form user'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    function: _formData['function'],
                    urlAvatar: _formData['urlAvatar'],
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(children: <Widget>[
            TextFormField(
              initialValue: _formData['name'],
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name cannot be empty.';
                }
                return null;
              },
              onSaved: (value) => _formData['name'] = value!,
            ),
            TextFormField(
              initialValue: _formData['function'],
              decoration: InputDecoration(labelText: 'Function'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Function cannot be empty.';
                }
                return null;
              },
              onSaved: (value) => _formData['function'] = value!,
            ),
            TextFormField(
              initialValue: _formData['urlAvatar'],
              decoration: InputDecoration(labelText: 'Url Image'),
              onSaved: (value) => _formData['urlAvatar'] = value!,
            ),
          ]),
        ),
      ),
    );
  }
}

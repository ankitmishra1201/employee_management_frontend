import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_app/screens/Admin/routes/app_routes.dart';

import '../models/user.dart';
import '../providers/users.dart';
class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.urlAvatar == null || user.urlAvatar.isEmpty
        ? CircleAvatar(child: Icon(Icons.backpack))
        : CircleAvatar(backgroundImage: NetworkImage(user.urlAvatar));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.function),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.USER_FOMR, arguments: user);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Delete user'),
                    content: Text('want to delete?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Provider.of<Users>(context, listen: false)
                              .remove(user);
                          Navigator.of(context).pop();
                        },
                        child: Text('Yes'),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

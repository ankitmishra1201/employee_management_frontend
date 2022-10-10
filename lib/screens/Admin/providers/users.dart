import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:task_app/screens/Admin/data/dummies.user.dart';
import 'package:task_app/screens/Admin/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USER};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id == null || user.id.isEmpty) {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          function: user.function,
          urlAvatar: user.urlAvatar,
        ),
      );
    } else if (_items.containsKey(user.id)) {
      _items.update(user.id, (_) => user);
    }

    notifyListeners();
  }

  void remove(User user) {
    // ignore: unnecessary_null_comparison
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}

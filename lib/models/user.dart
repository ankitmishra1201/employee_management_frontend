import 'dart:convert';
import 'dart:ffi';

class User {
  final String id;
  final String name;
  final String email;
  final String department;
  final int contactno;
  final DateTime dateofjoin;
  final String token;
  final String password;
  final String role;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.password,
    required this.contactno,
    required this.dateofjoin,
    required this.department,
    required this.role
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'token': token,
      'password': password,
      'contactno':contactno,
      'dateofjoin': dateofjoin,
      'department': department,
    };
  }

  factory User.fromJSON(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
      contactno: map['contactno']??123456,
      dateofjoin: map['dateofjoin']??DateTime.now(),
      department: map['department']??'',
      role: map['role']??''
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromJSON(json.decode(source));
}

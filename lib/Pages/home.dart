import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({Key key, @required this.user}) : super(key: key);
  final AuthResult user;
  @override
  _HomeState createState() => _HomeState(this.user);
}

class _HomeState extends State<Home> {
  _HomeState(this.user);
  AuthResult user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        automaticallyImplyLeading: false,
        title: Text('TODO ${user.user.email}'),
      ),
      body: Text(''),
    );
  }
}

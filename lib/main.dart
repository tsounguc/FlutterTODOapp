import 'package:flutter/material.dart';
import 'package:fluttertodoapp/Login_And_Auth/auth.dart';
import 'package:fluttertodoapp/Pages/welcome.dart';
import 'package:fluttertodoapp/routingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: RoutingPage(new Auth()), // removed original title
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

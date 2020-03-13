import 'package:flutter/material.dart';
import 'package:fluttertodoapp/Pages/welcome.dart';

void main() => runApp(ListeDeTachesApp());

class ListeDeTachesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste de Tâches',
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

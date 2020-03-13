import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertodoapp/Login_And_Auth/auth.dart';
import 'package:fluttertodoapp/Login_And_Auth/logIn.dart';
import 'package:fluttertodoapp/Pages/signUp.dart';
import 'package:fluttertodoapp/routingPage.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 6),
      () => Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
          builder: (context) => RoutingPage(new Auth()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
//            Colors.deepOrange,
            Colors.orange,
            Colors.orangeAccent,
          ],
        ),
        image: DecorationImage(
            image: AssetImage('assets/images/Mountains.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 50.0, right: 8.0, bottom: 50),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Welcome to',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Liste de tâches',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    Container(
                      height: 50,
                    ),
                    Center(
                      child: Text(
                        'TODO app',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Center(
                      child: Text(
                        'by Christian TN',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: SizedBox(
//                  width: 200,
//                  height: 50,
//                  child: RaisedButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(30)),
//                    color: Colors.white,
//                    onPressed: navigateToLogInPage,
//                    child: Text('Log In'),
//                  ),
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: SizedBox(
//                  width: 200,
//                  height: 50,
//                  child: RaisedButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(30)),
//                    color: Colors.white,
//                    onPressed: navigateToSingUpPage,
//                    child: Text('Sign Up'),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToLogInPage() {
//    Route route = MaterialPageRoute(
//        builder: (context) => LoginPage(new Auth()), fullscreenDialog: false);
//    Navigator.pushReplacement(context, route);
  }

  void navigateToSingUpPage() {
//    Route route = MaterialPageRoute(
//        builder: (context) => SignUpPage(new Auth()), fullscreenDialog: false);
//    Navigator.pushReplacement(context, route);
  }
}

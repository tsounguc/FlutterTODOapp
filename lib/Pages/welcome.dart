import 'package:flutter/material.dart';
import 'package:fluttertodoapp/Login_And_Auth/logIn.dart';
import 'package:fluttertodoapp/Pages/signUp.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Mountains.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
//        appBar: AppBar(
////        title: Text('Sign Up'),
//          backgroundColor: Colors.transparent,
//        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 50.0, right: 8.0, bottom: 50),
                child: Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(color: Colors.white, fontSize: 70),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30)),
                    color: Colors.white,
                    onPressed: navigateToLogInPage,
                    child: Text('Log in'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30)),
                    color: Colors.white,
                    onPressed: navigateToSingUpPage,
                    child: Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToLogInPage() {
    Route route = MaterialPageRoute(
        builder: (context) => LoginPage(), fullscreenDialog: false);
    Navigator.push(context, route);
  }

  void navigateToSingUpPage() {
    Route route = MaterialPageRoute(
        builder: (context) => SignUpPage(), fullscreenDialog: false);
    Navigator.push(context, route);
  }
}

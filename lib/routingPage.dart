import 'package:flutter/material.dart';
import 'package:fluttertodoapp/Login_And_Auth/auth.dart';
import 'package:fluttertodoapp/Login_And_Auth/logIn.dart';
import 'package:fluttertodoapp/Pages/signUp.dart';
import 'package:fluttertodoapp/Pages/todoList.dart';
import 'package:firebase_auth/firebase_auth.dart';
///*****************************************************************************
///* Description: This class routes the app to different pages based on input from user.
///* It helps to keep the user logged in if he/she gets out of app without
///* logging out
///* Author: Christian Tsoungui Nkoulou
///* Date: March 13, 2020
///*****************************************************************************
class RoutingPage extends StatefulWidget {
  RoutingPage(this.auth);
  final BaseAuth auth;
  @override
  _RoutingPageState createState() => _RoutingPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

enum FormType {
  login,
  register,
}

class _RoutingPageState extends State<RoutingPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  FormType _formtype = FormType.login;
  String userEmail;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        if (_formtype == FormType.login) {
          return new LoginPage(widget.auth, _signedIn, signUpForm);
        } else if (_formtype == FormType.register) {
          return new SignUpPage(widget.auth, _signOut, logInForm);
        }
        break;
      case AuthStatus.signedIn:
        return TodoList(widget.auth, _signOut, currentUser);
    }
  }

  //Gets current user info
  _getCurrentUser() async {
    currentUser = await widget.auth.currentUser();
    setState(() {
      _authStatus =
          currentUser != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
    });
  }

  //Sets formtype enum to login
  void logInForm() {
    setState(() {
      _formtype = FormType.login;
    });
  }

  //Sets formtype enum to register
  void signUpForm() {
    setState(() {
      _formtype = FormType.register;
    });
  }

  //Sets authentication status to signedIn and calls _getCurrentUser()
  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
    _getCurrentUser();
  }

  //Sets authentication status to notSigned in
  void _signOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }
}

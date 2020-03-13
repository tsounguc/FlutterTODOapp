import 'package:flutter/material.dart';
import 'package:fluttertodoapp/Login_And_Auth/auth.dart';
import 'package:fluttertodoapp/Login_And_Auth/logIn.dart';
import 'package:fluttertodoapp/Pages/signUp.dart';
import 'package:fluttertodoapp/Pages/todoList.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  _getCurrentUser() async {
    currentUser = await widget.auth.currentUser();
    setState(() {
      _authStatus =
          currentUser != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
    });
  }

  void logInForm() {
    setState(() {
      _formtype = FormType.login;
    });
  }

  void signUpForm() {
    setState(() {
      _formtype = FormType.register;
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
    _getCurrentUser();
  }

  void _signOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
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
}

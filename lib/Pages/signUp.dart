import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertodoapp/Login_And_Auth/auth.dart';
///*****************************************************************************
///* Description: This class displays the UI for the creating an account
///* Author: Christian Tsoungui Nkoulou
///* Date: March 13, 2020
///*****************************************************************************
class SignUpPage extends StatefulWidget {
  SignUpPage(this.auth, this.onSignedOut, this.onLogInForm);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final VoidCallback onLogInForm;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.orange,
            Colors.orangeAccent,
          ],
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/Mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      //TODO: implement fields
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 150.0, right: 8.0, bottom: 100),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 0.0, right: 0.0, bottom: 15.0),
                        child: TextFormField(
                          autofocus: false,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please type a valid email';
                            }
                            return null;
                          },
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 0.0, right: 0.0, bottom: 15.0),
                        child: TextFormField(
                          autofocus: false,
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Password must have at least 6 characters';
                            }
                            return null;
                          },
                          onSaved: (input) => _password = input,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                      ),

                      SizedBox(
                        width: 200,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          color: Colors.white,
                          onPressed: signUp,
                          child: Text('Create Account'),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          color: Colors.transparent,
                          onPressed: navigateToLogInPage,
                          child: Text(
                            'Have an account?  Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        String userEmail =
            await widget.auth.createUserWithEmailAndPassword(_email, _password);
//        user.sendEmailVerification();
        Firestore.instance
            .collection('users')
            .document('$userEmail')
            .setData({});
        Firestore.instance
            .collection('users')
            .document('$userEmail')
            .collection('tasks')
            .add({});
        navigateToLogInPage();
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('${e.message}'),
        ));
      }
    }
  }

  void navigateToLogInPage() {
    widget.onLogInForm();
  }
}

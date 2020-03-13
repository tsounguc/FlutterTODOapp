import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.auth, this.onSignedIn, this.onSignUpForm);

  final BaseAuth auth;
  final VoidCallback onSignedIn;
  final VoidCallback onSignUpForm;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafforldKey = GlobalKey<ScaffoldState>();
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
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        key: _scafforldKey,
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
                            'Log In',
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
                          onPressed: logIn,
                          child: Text('Log in'),
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
                          onPressed: navigateToSingUpPage,
                          child: Text(
                            'Create an account',
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

  //Signs in user after login button is pressed
  Future<void> logIn() async {
    //TODO Validate fields
    final formState = _formkey.currentState;
    if (formState.validate()) {
      //TODO Login to firebase
      formState.save();
      try {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
        widget.onSignedIn();
      } catch (e) {
        print(e.message);
        _scafforldKey.currentState.showSnackBar(SnackBar(
          content: Text('${e.message}'),
          duration: Duration(seconds: 5),
        ));
      }
    }
  }

  //Uses callback function to navigate to sign up page
  void navigateToSingUpPage() {
    widget.onSignUpForm();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertodoapp/Pages/todoList.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
        appBar: AppBar(
//          title: Text('Log in'),
          backgroundColor: Colors.transparent,
        ),
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
                    children: <Widget>[
                      //TODO: implement fields
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 50.0, right: 8.0, bottom: 50),
                        child: Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          autofocus: true,
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
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          autofocus: true,
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
                              borderRadius: BorderRadius.circular(30.0),
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
                              borderRadius: new BorderRadius.circular(30)),
                          color: Colors.white,
                          onPressed: LogIn,
                          child: Text('Log in'),
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

  Future<void> LogIn() async {
    //TODO Validate fields
    final formState = _formkey.currentState;
    if (formState.validate()) {
      //TODO Login to firebase
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        //TODO Navigate to todolist page
        Route route =
            MaterialPageRoute(builder: (context) => TodoList(user: user));
        Navigator.push(context, route);
      } catch (e) {
        print(e.message);
      }
    }
  }
}

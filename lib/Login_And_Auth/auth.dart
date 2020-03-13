import 'package:firebase_auth/firebase_auth.dart';

///*****************************************************************************
///* Description: The class Auth is for authentication. It implements an
///* abstract BaseAuth, which has methods for creating a user, signing in
///* and out a user, and getting the currentUser. The purpose of this class
///* is to make the code for authentication more modular; if we choose to
///* a different backend, all we have to do is change the firebase code in
///* this class
///* Author: Christian Tsoungui Nkoulou
///* Date: March 13, 2020
///*****************************************************************************
abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<FirebaseUser> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  //Signs user in with email and password
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password))
        .user;
    return user.email;
  }

  //Creates user with email and password and return the user's email
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;
    return user.email;
  }

  //Gets current user
  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  //Signs out user
  Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }
}

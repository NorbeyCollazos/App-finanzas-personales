import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth;

  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  void checkIfUserIsLogged(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, 'gastos', (route) => false);
      }
    });
  }

  Future<bool> login(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print(error);
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<bool> register(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print(error);
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<bool> forgotPass(String email) async {
    String errorMessage;

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error);
      errorMessage = error.code;
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}

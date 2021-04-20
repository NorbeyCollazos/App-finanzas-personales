import 'package:app_finanzas_personales/src/providers/auth_provider.dart';
import 'package:app_finanzas_personales/src/utils/snackbar.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider _authProvider;

  Future init(BuildContext context) {
    this.context = context;
    _authProvider = new AuthProvider();
    _authProvider.checkIfUserIsLogged(context); //para saber si esta logueado
  }

  void goToRegister() {
    Navigator.pushNamed(context, 'register');
  }

  void goToHome() {
    Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print("Email: $email");
    print("Password: $password");

    //_progressDialog.show();

    try {
      bool isLogin = await _authProvider.login(email, password);
      //_progressDialog.hide();
      if (isLogin) {
        //_progressDialog.hide();
        print('Esta logueado');
        goToHome();
      } else {
        print('No se pudo autenticar');
        // _progressDialog.hide();
      }
    } catch (error) {
      //_progressDialog.hide();
      print('Error: $error');
      utils.Snackbar.showSnackbar(context, key, 'Error: $error', Colors.red);
    }
  }
}

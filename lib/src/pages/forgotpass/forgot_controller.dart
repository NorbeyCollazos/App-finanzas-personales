import 'package:app_finanzas_personales/src/providers/auth_provider.dart';
import 'package:app_finanzas_personales/src/utils/snackbar.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotController {
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

  void goToForgotPass() {
    Navigator.pushNamed(context, 'forgotpass');
  }

  void forgotPass() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      utils.Snackbar.showSnackbar(
          context, key, 'Por favor ingrese el correo', Colors.amber);
      return;
    }

    print("Email: $email");

    //_progressDialog.show();

    try {
      bool isForgot = await _authProvider.forgotPass(email);
      //_progressDialog.hide();
      if (isForgot) {
        //_progressDialog.hide();
        utils.Snackbar.showSnackbar(
            context,
            key,
            'Se envió la solicitud al correo, por favor revice su bandeja de entrada',
            Colors.green);
        Navigator.of(context).pop();
      } else {
        print('No se pudo enviar la solicitud');
        utils.Snackbar.showSnackbar(
            context, key, 'No se pudo enviar la solicitud', Colors.amber);
        // _progressDialog.hide();
      }
    } catch (error) {
      //_progressDialog.hide();
      print('Error: $error');
      utils.Snackbar.showSnackbar(context, key, 'Error: $error', Colors.red);
    }
  }
}

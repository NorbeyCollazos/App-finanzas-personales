import 'package:app_finanzas_personales/src/models/person.dart';
import 'package:app_finanzas_personales/src/providers/auth_provider.dart';
import 'package:app_finanzas_personales/src/providers/user_provider.dart';
import 'package:app_finanzas_personales/src/utils/my_progress_dialog.dart';
import 'package:app_finanzas_personales/src/utils/snackbar.dart' as utils;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegisterController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repeatpasswordController = new TextEditingController();

  AuthProvider _authProvider;
  UserProvider _userProvider;
  ProgressDialog _progressDialog;

  Future init(BuildContext context) {
    this.context = context;
    _authProvider = new AuthProvider();
    _userProvider = new UserProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento');
  }

  void register() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmpassword = repeatpasswordController.text.trim();

    print("Email: $email");
    print("Password: $password");

    if (username.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmpassword.isEmpty) {
      print('campos vacios');
      utils.Snackbar.showSnackbar(
          context, key, 'Debes ingresar todos los campos', Colors.red);
      return;
    }

    if (confirmpassword != password) {
      utils.Snackbar.showSnackbar(
          context, key, 'Las contraseñas no coinciden', Colors.red);
      return;
    }

    if (password.length < 6) {
      utils.Snackbar.showSnackbar(context, key,
          'Las contraseña debe contener al menos 6 caracteres', Colors.red);
      return;
    }

    _progressDialog.show();

    try {
      bool isRegister = await _authProvider.register(email, password);
      if (isRegister) {
        Person person = new Person(
          id: _authProvider.getUser().uid,
          email: _authProvider.getUser().email,
          username: username,
        );
        await _userProvider.create(person);
        _progressDialog.hide();
        utils.Snackbar.showSnackbar(
            context, key, 'Registro exitoso', Colors.green);
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      } else {
        _progressDialog.hide();
        print('No se pudo registrar');
      }
    } catch (error) {
      _progressDialog.hide();
      print('Error: $error');
      utils.Snackbar.showSnackbar(context, key, 'Error: $error', Colors.red);
    }
  }
}

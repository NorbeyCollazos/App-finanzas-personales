import 'package:app_finanzas_personales/src/models/person.dart';
import 'package:app_finanzas_personales/src/providers/auth_provider.dart';
import 'package:app_finanzas_personales/src/providers/user_provider.dart';
import 'package:app_finanzas_personales/src/utils/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeController {
  BuildContext context;
  Function refresh;

  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  AuthProvider _authProvider;
  UserProvider _userProvider;
  SharedPref _sharedPref;
  String _idUser;

  Person person;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _userProvider = new UserProvider();
    _sharedPref = new SharedPref();
    getPersonInfo();
    _idUser = await _sharedPref.read('idUser');
    //print('Usuario: ' + _idUser);
  }

  void cerrarSesion() async {
    await _authProvider.signOut();
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    //SystemNavigator.pop();
  }

  void getPersonInfo() {
    //print('Id de usuario: ' + _authProvider.getUser().uid);
    _sharedPref.save('idUser', _authProvider.getUser().uid);
    Stream<DocumentSnapshot> personStream =
        _userProvider.getByIdStream(_authProvider.getUser().uid);

    personStream.listen((DocumentSnapshot documnet) {
      person = Person.fromJson(documnet.data());
      refresh();
    });
  }

  void mostrarPrefIdUser() {
    print('USUARIO ID: ' + _idUser);
    //utils.Snackbar.showSnackbar(context, key, _idUser, Colors.green);
  }

  void goToGastos() {
    Navigator.pushNamed(context, 'gastos');
  }
}
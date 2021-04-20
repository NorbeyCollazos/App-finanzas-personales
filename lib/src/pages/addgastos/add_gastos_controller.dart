import 'package:app_finanzas_personales/src/utils/shared_pref.dart';
import 'package:app_finanzas_personales/src/utils/snackbar.dart'
    as utilsnackbar;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddGastosController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  SharedPref _sharedPref;
  String _idUser;

  Future init(BuildContext context) async {
    this.context = context;
    _sharedPref = new SharedPref();
    _idUser = await _sharedPref.read('idUser');
  }

  void registrarGasto(int value, String category) {
    if (value == 0) {
      utilsnackbar.Snackbar.showSnackbar(
          context, key, "Ingrese el valor", Colors.amber);
    } else if (category == null || category == "") {
      utilsnackbar.Snackbar.showSnackbar(
          context, key, "Seleccione la categoría", Colors.amber);
    } else {
      Navigator.of(context).pop();
      print(category);

      FirebaseFirestore.instance
          .collection('Users')
          .doc(_idUser)
          .collection('gastos')
          .doc()
          .set({
        "category": category,
        "value": value,
        "month": DateTime.now().month,
        "day": DateTime.now().day,
      });
    }
  }
}

import 'package:app_finanzas_personales/src/providers/gastos_provider.dart';
import 'package:app_finanzas_personales/src/utils/shared_pref.dart';
import 'package:app_finanzas_personales/src/utils/snackbar.dart'
    as utilsnackbar;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text/flutter_masked_text.Dart';

class AddGastosController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  SharedPref _sharedPref;
  String _idUser;

  TextEditingController valueController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  //final valueController = MoneyMaskedTextController(
  //decimalSeparator: '.', thousandSeparator: ','); //after

  Future init(BuildContext context) async {
    this.context = context;
    _sharedPref = new SharedPref();
    _idUser = await _sharedPref.read('idUser');
  }

  void registrarGasto(int value, String category, DateTime date) {
    //String val = valueController.text;
    //int value = int.parse(val);

    if (value == 0) {
      utilsnackbar.Snackbar.showSnackbar(
          context, key, "Ingrese el valor", Colors.amber);
    } else if (category == null || category == "") {
      utilsnackbar.Snackbar.showSnackbar(
          context, key, "Seleccione la categoría", Colors.amber);
    } else {
      Navigator.of(context).pop();
      print(category);
      String description = descriptionController.text;
      var today = DateTime.now();
      var db = GastosRepository(_idUser);
      db.add(category, value, description, date);
    }
  }

  String mostrarValue() {
    String value = valueController.text = "0";
    NumberFormat f = new NumberFormat("#,##0", "es_CO");
    return "\$${f.format(value)}";
  }
}

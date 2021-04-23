import 'package:app_finanzas_personales/src/utils/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IngresosController {
  BuildContext context;
  int currentPage = DateTime.now().month - 1;
  Stream<QuerySnapshot> _query;

  SharedPref _sharedPref;
  String _idUser;

  Future init(BuildContext context) async {
    this.context = context;
    _sharedPref = new SharedPref();
    _idUser = await _sharedPref.read('idUser');
  }

  void goToAddIngresos() {
    Navigator.pushNamed(context, 'addIngresos');
  }

  void goToGastos() {
    Navigator.pushNamed(context, 'gastos');
  }

  Future<String> prefIdUser() async {
    String _id = await _sharedPref.read('idUser');
    return _id;
  }

  void consultaBD() {
    FirebaseFirestore.instance
        .collection('expenses')
        .where("month", isEqualTo: currentPage + 1)
        .snapshots();
  }

  IconData tipoIcono(String key) {
    IconData icon = null;
    if (key == "Compras") icon = FontAwesomeIcons.shoppingCart;
    if (key == "Comida") icon = FontAwesomeIcons.hamburger;
    if (key == "Viajes") icon = FontAwesomeIcons.umbrellaBeach;
    if (key == "Transporte") icon = FontAwesomeIcons.bus;
    if (key == "Ropa") icon = FontAwesomeIcons.tshirt;
    if (key == "Salud") icon = FontAwesomeIcons.medkit;
    if (key == "Educación") icon = FontAwesomeIcons.graduationCap;
    if (key == "Gimnasio") icon = FontAwesomeIcons.biking;
    if (key == "Regalos") icon = FontAwesomeIcons.gift;
    if (key == "Otros") icon = FontAwesomeIcons.plus;

    return icon;
  }
}

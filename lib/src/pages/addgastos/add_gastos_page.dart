import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:app_finanzas_personales/src/widgets/button_app.dart';
import 'package:app_finanzas_personales/src/widgets/category_selection_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'add_gastos_controller.dart';

class AddGastosPage extends StatefulWidget {
  AddGastosPage({Key key}) : super(key: key);

  @override
  _AddGastosPageState createState() => _AddGastosPageState();
}

class _AddGastosPageState extends State<AddGastosPage> {
  NumberFormat f = new NumberFormat("#,##0", "es_CO");
  String category;
  int value = 0;
  AddGastosController _con = new AddGastosController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _categorySelector(),
        _currentValue(),
        _numpad(),
        // _submit(),
        _btnSubmit()
      ],
    );
  }

  _categorySelector() {
    return Container(
      height: 120,
      child: CategorySelectionWidget(
        categories: {
          "Compras": FontAwesomeIcons.shoppingCart,
          "Comida": FontAwesomeIcons.hamburger,
          "Viajes": FontAwesomeIcons.umbrellaBeach,
          "Transporte": FontAwesomeIcons.bus,
          "Ropa": FontAwesomeIcons.tshirt,
          "Salud": FontAwesomeIcons.medkit,
          "Educación": FontAwesomeIcons.graduationCap,
          "Gimnasio": FontAwesomeIcons.biking,
          "Regalos": FontAwesomeIcons.gift,
          "Otros": FontAwesomeIcons.plus,
        },
        onValueChanged: (newCategory) => category = newCategory,
      ),
    );
  }

  Widget _currentValue() {
    //var realValue = value / 100.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        "\$${f.format(value)}",
        style: TextStyle(
          fontSize: 50.0,
          color: utilscolor.Colors.colorAccent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _num(String text, double height) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          if (text == ",") {
            value = value * 100;
          } else {
            value = value * 10 + int.parse(text);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(2),
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 40,
              color: Colors.grey,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              offset: new Offset(0.0, 5.0),
              blurRadius: 3.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _numpad() {
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var height = constraints.biggest.height / 4.3;

        return Table(
          /*border: TableBorder.all(
            color: Colors.grey,
            width: 1.0,
          ),*/
          children: [
            TableRow(children: [
              _num("1", height),
              _num("2", height),
              _num("3", height),
            ]),
            TableRow(children: [
              _num("4", height),
              _num("5", height),
              _num("6", height),
            ]),
            TableRow(children: [
              _num("7", height),
              _num("8", height),
              _num("9", height),
            ]),
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    value = 0;
                  });
                },
                child: Container(
                  height: height,
                  child: Center(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
              ),
              _num("0", height),
              GestureDetector(
                onTap: () {
                  setState(() {
                    value = value ~/ 10;
                  });
                },
                child: Container(
                  height: height,
                  child: Center(
                    child: Icon(
                      Icons.backspace,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        );
      }),
    );
  }

  Widget _btnSubmit() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: () {
          _con.registrarGasto(value, category);
        },
        text: "Registrar Gasto",
        color: utilscolor.Colors.colorAccent,
        icon: Icons.save,
      ),
    );
  }

  Widget _submit() {
    return Builder(builder: (BuildContext context) {
      return Hero(
        tag: "add_button",
        child: Container(
          height: 50.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          child: MaterialButton(
            child: Text(
              "Registrar gasto",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              if (value == 0) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Ingrese el valor")));
              } else if (category == null || category == "") {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Seleccione la categoría")));
              } else {
                Navigator.of(context).pop();
                print(category);

                FirebaseFirestore.instance
                    .collection('Users')
                    .doc('A5rEAyUTlTUJml1Ysldw6qumGGv2')
                    .collection('gastos')
                    .doc()
                    .set({
                  "category": category,
                  "value": value,
                  "month": DateTime.now().month,
                  "day": DateTime.now().day,
                });
              }
            },
          ),
        ),
      );
    });
  }
}

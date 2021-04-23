import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:app_finanzas_personales/src/widgets/button_app.dart';
import 'package:app_finanzas_personales/src/widgets/category_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'add_ingresos_controller.dart';

class AddIngresosPage extends StatefulWidget {
  AddIngresosPage({Key key}) : super(key: key);

  @override
  _AddIngresosPageState createState() => _AddIngresosPageState();
}

class _AddIngresosPageState extends State<AddIngresosPage> {
  NumberFormat f = new NumberFormat("#,##0", "es_CO");
  String dateStr = "Hoy";
  DateTime date = DateTime.now();

  String category;
  int value = 0;
  AddIngresosController _con = new AddIngresosController();

  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

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
      appBar: AppBar(
        title: Text("Registrar Ingreso"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          _categorySelector(),
          _currentValue(),
          _textfieldValue(),
          _textfieldDescription(),
          _botonFecha(),
          //_numpad(),
          // _submit(),
          _btnSubmit()
        ],
      ),
    );
  }

  _categorySelector() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 120,
      child: CategorySelectionWidget(
        categories: {
          "Salario": FontAwesomeIcons.handHoldingUsd,
          "Intereses": FontAwesomeIcons.university,
          "Ahorros": FontAwesomeIcons.piggyBank,
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
        //_con.mostrarValue(),
        style: TextStyle(
          fontSize: 50.0,
          color: utilscolor.Colors.colorAccent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _botonFecha() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: RaisedButton.icon(
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(hours: 24 * 60)),
            lastDate: DateTime.now(),
          ).then((newDate) {
            if (newDate != null) {
              setState(() {
                date = newDate;
                dateStr =
                    "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}";
              });
            }
          });
        },
        icon: Icon(
          FontAwesomeIcons.calendarDay,
          color: Colors.grey,
        ),
        label: Text(
          dateStr,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _btnSubmit() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: () {
          _con.registrarGasto(value, category, date);
          print(date);
        },
        text: "Registrar Ingreso",
        color: utilscolor.Colors.colorAccent,
        icon: Icons.save,
      ),
    );
  }

  Widget _textfieldValue() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.valueController,
        keyboardType: TextInputType.number,
        /*onChanged: (string) {
          string = '${_formatNumber(string.replaceAll(',', ''))}';
          _con.valueController.value = TextEditingValue(
            text: string,
            selection: TextSelection.collapsed(offset: string.length),
          );
        },*/
        onChanged: (text) {
          //print("Valor: $value");
          setState(() {
            if (text == "") {
              value = 0;
            }
            value = int.parse(text);
          });
        },
        decoration: InputDecoration(
          hintText: "ingrese el valor",
          labelText: "Valor",
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: new BorderSide(
              color: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _textfieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.descriptionController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: "Ingrese la descripción",
          labelText: "Descripción (opcional)",
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: new BorderSide(
              color: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }

  /* Widget _submit() {
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
                    .collection('Ingresos')
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
  }*/

  void refresh() {
    setState(() {});
  }
}

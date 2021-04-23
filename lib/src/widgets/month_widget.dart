import 'package:app_finanzas_personales/src/pages/detailgastos/detail_gastos_page.dart';
import 'package:app_finanzas_personales/src/pages/gastos/gastos_controller.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'graph_widget.dart';
import 'package:intl/intl.dart';

class MonthWidget extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<String, double> categories;
  final int month;

  MonthWidget({Key key, this.documents, this.month})
      : total = documents.map((doc) => doc['value']).fold(0.0, (a, b) => a + b),
        perDay = List.generate(30, (int index) {
          return documents
              .where((doc) => doc['day'] == (index + 1))
              .map((doc) => doc['value'])
              .fold(0.0, (a, b) => a + b);
        }),
        categories = documents.fold({}, (Map<String, double> map, document) {
          if (!map.containsKey(document['category'])) {
            map[document['category']] = 0.0;
          }
          map[document['category']] += document['value'];
          return map;
        }),
        super(key: key);

  @override
  _MonthWidgetState createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  GastosController _con = new GastosController();
  @override
  void initState() {
    super.initState();
    _con.init(context);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.categories);
    return Expanded(
      child: Column(
        children: [
          _expenses(),
          _graph(),
          _list(),
        ],
      ),
    );
  }

  Widget _expenses() {
    NumberFormat f = new NumberFormat("#,##0", "es_CO");
    return Column(
      children: [
        Text(
          "\$${f.format(widget.total)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        Text(
          "Total en gastos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _graph() {
    return Container(
      height: 200.0,
      child: GraphWidget(
        data: widget.perDay,
      ),
    );
  }

  Widget _item(IconData icon, String name, int percent, double value) {
    NumberFormat f = new NumberFormat("#,##0", "es_CO");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/details',
                arguments: DetailsParams(name, widget.month));
          },
          leading: Icon(
            icon,
            color: utilscolor.Colors.colorAccent,
            size: 35,
          ),
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("$percent% de gastos"),
          trailing: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: utilscolor.Colors.lighPrimary,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              "\$${f.format(value)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.categories.keys.length,
        itemBuilder: (BuildContext context, int position) {
          var key = widget.categories.keys.elementAt(position);
          var data = widget.categories[key];
          IconData icon = _con.tipoIcono(key);
          return _item(icon, key, 100 * data ~/ widget.total, data);
        },
      ),
    );
  }
}

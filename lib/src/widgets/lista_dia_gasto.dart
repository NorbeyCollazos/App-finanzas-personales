import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaDiaGasto extends StatelessWidget {
  const ListaDiaGasto({
    Key key,
    @required this.document,
    @required this.f,
  }) : super(key: key);

  final QueryDocumentSnapshot document;
  final NumberFormat f;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          document['day'].toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        decoration: BoxDecoration(
          color: utilscolor.Colors.lighPrimary,
          shape: BoxShape.circle,
          border: Border.all(color: utilscolor.Colors.colorPrimary, width: 2),
        ),
      ),
      title: Text(
        //document['value'].toString(),
        "\$ ${f.format(document['value'])}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(document['description']),
    );
  }
}

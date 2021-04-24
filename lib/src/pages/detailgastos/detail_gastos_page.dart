import 'package:app_finanzas_personales/src/providers/auth_provider.dart';
import 'package:app_finanzas_personales/src/providers/gastos_provider.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:app_finanzas_personales/src/widgets/alert_dialog.dart';
import 'package:app_finanzas_personales/src/widgets/lista_dia_gasto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsParams {
  final String categoryName;
  final int month;

  DetailsParams(this.categoryName, this.month);
}

class DetailsPage extends StatefulWidget {
  final DetailsParams params;
  DetailsPage({Key key, this.params}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  AuthProvider _authProvider;
  Stream<QuerySnapshot> _query;
  NumberFormat f = new NumberFormat("#,##0", "es_CO");

  @override
  void initState() {
    super.initState();
    _authProvider = new AuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    //hacemos la consulta a la BD
    var db = GastosRepository(_authProvider.getUser().uid);
    var _query =
        db.queryByCategory(widget.params.month + 1, widget.params.categoryName);
    print("User ID: " + _authProvider.getUser().uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.params.categoryName),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _query,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
          if (data.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var document = data.data.docs[index];
                return Dismissible(
                  key: Key(document.documentID),
                  //para el fondo
                  background: Container(color: Colors.red),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.delete, color: Colors.white),
                          Text('Eliminar Gasto',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),

                  confirmDismiss: (direction) async {
                    //return await showAlertDialog(document.documentID);
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Eliminar Gasto"),
                          content:
                              const Text("¿Seguro desea eliminar este gasto?"),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                  db.delete(document.documentID);
                                },
                                child: const Text("Eliminar")),
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Cancelar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    child: ListaDiaGasto(document: document, f: f),
                  ),
                );
              },
              itemCount: data.data.docs.length,
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

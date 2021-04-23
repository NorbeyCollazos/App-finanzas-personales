import 'package:app_finanzas_personales/src/pages/ingresos/ingresos_controller.dart';
import 'package:app_finanzas_personales/src/providers/auth_provider.dart';
import 'package:app_finanzas_personales/src/providers/ingresos_provider.dart';

import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:app_finanzas_personales/src/utils/shared_pref.dart';
import 'package:app_finanzas_personales/src/widgets/month_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class IngresosPage extends StatefulWidget {
  IngresosPage({Key key}) : super(key: key);

  @override
  _IngresosPageState createState() => _IngresosPageState();
}

class _IngresosPageState extends State<IngresosPage> {
  IngresosController _con = new IngresosController();
  PageController _controller;
  int currentPage = DateTime.now().month - 1;
  Stream<QuerySnapshot> _query;
  SharedPref _sharedPref;
  String _idUser;
  AuthProvider _authProvider;
  var db;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });

    _sharedPref = new SharedPref();
    _authProvider = new AuthProvider();

    db = IngresosRepository(_authProvider.getUser().uid);

    _query = db.queryByMonth(currentPage + 1);

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: utilscolor.Colors.colorPrimary,
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bottomAction('assets/img/ic_gastos.png', 45.0, 150, () {
              _con.goToGastos();
            }),
            _bottomAction('assets/img/ic_ingresos.png', 50.0, 500, () {}),
            _bottomAction('assets/img/ic_info.png', 35.0, 150, () {}),
            SizedBox(
              width: 32.0,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _con.goToAddIngresos,
      ),
      body: _body(),
    );
  }

  Widget _bottomAction(
      String dataimg, double width, int alpha, Function callback) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          dataimg,
          color: Colors.white.withAlpha(alpha),
          width: width,
        ),
      ),
      onTap: callback,
    );
  }

  Widget _body() {
    return Column(
      children: [
        _banerTop(),
        //_selector(),
        StreamBuilder<QuerySnapshot>(
          stream: _query,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
            if (data.data.docs.length > 0) {
              return MonthWidget(
                documents: data.data.docs,
                month: currentPage,
                titulo: "Ingresos",
              );
            } else {
              return Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/img/ic_vacio.png'),
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "No hay Ingresos registrados en este mes, pulsa en el botón + para agregar",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ));
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }

  Widget _banerTop() {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: 120,
        color: utilscolor.Colors.colorPrimary,
        child: Center(
          child: SizedBox.fromSize(
            size: Size.fromHeight(70.0),
            child: PageView(
              onPageChanged: (newPage) {
                setState(() {
                  currentPage = newPage;
                  _query = db.queryByMonth(currentPage + 1);
                });
              },
              controller: _controller,
              children: [
                _pageItem("ENERO", 0),
                _pageItem("FEBRERO", 1),
                _pageItem("MARZO", 2),
                _pageItem("ABRIL", 3),
                _pageItem("MAYO", 4),
                _pageItem("JUNIO", 5),
                _pageItem("JULIO", 6),
                _pageItem("AGOSTO", 7),
                _pageItem("SEPTIEMBRE", 8),
                _pageItem("OCTUBRE", 9),
                _pageItem("NOVIEMBRE", 10),
                _pageItem("DICIEMBRE", 11),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageItem(String name, int position) {
    var _aligment;

    final selected = TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        decoration: TextDecoration.underline);
    final unselected = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.normal,
      color: Colors.white.withOpacity(0.4),
    );

    if (position == currentPage) {
      _aligment = Alignment.center;
    } else if (position > currentPage) {
      _aligment = Alignment.centerRight;
    } else {
      _aligment = Alignment.centerLeft;
    }
    return Align(
      alignment: _aligment,
      child: Text(
        name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }
}

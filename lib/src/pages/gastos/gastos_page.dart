import 'package:app_finanzas_personales/src/pages/gastos/gastos_controller.dart';
import 'package:app_finanzas_personales/src/providers/auth_provider.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:app_finanzas_personales/src/utils/shared_pref.dart';
import 'package:app_finanzas_personales/src/widgets/month_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class GastosPage extends StatefulWidget {
  GastosPage({Key key}) : super(key: key);

  @override
  _GastosPageState createState() => _GastosPageState();
}

class _GastosPageState extends State<GastosPage> {
  GastosController _con = new GastosController();
  PageController _controller;
  int currentPage = DateTime.now().month - 1;
  Stream<QuerySnapshot> _query;
  SharedPref _sharedPref;
  String _idUser;
  AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });

    _sharedPref = new SharedPref();
    _authProvider = new AuthProvider();

    _query = FirebaseFirestore.instance
        .collection('Users')
        .doc(_authProvider.getUser().uid)
        .collection('gastos')
        .where("month", isEqualTo: currentPage + 1)
        .snapshots();

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _con.goToAddGastos,
      ),
      body: _body(),
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
            if (data.hasData) {
              return MonthWidget(
                documents: data.data.docs,
              );
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
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        color: utilscolor.Colors.colorPrimary,
        child: Center(
          child: SizedBox.fromSize(
            size: Size.fromHeight(70.0),
            child: PageView(
              onPageChanged: (newPage) {
                setState(() {
                  currentPage = newPage;
                  _query = FirebaseFirestore.instance
                      .collection('Users')
                      .doc(_authProvider.getUser().uid)
                      .collection('gastos')
                      .where("month", isEqualTo: currentPage + 1)
                      .snapshots();
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

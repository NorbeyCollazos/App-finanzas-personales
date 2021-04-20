import 'package:app_finanzas_personales/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _con = new HomeController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          _banerTop(),
          //_banerBottom(),
          _textTitulo(),
          _contentGastos(),
          _contentIngresos(),
        ],
      ),
    ));
  }

  Widget _banerTop() {
    return ClipPath(
      clipper: SideCutClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        color: utilscolor.Colors.colorPrimary,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¡Hola!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            Text(
              _con.person?.username ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _textTitulo() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        "Registra tus Gastos y/o Ingresos",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _contentGastos() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: [
            Image.asset(
              'assets/img/icono_gastos.png',
              width: 85,
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(
                "Registrar gastos",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                _con.goToGastos();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _contentIngresos() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: [
            Image.asset(
              'assets/img/icono_ingresos.png',
              width: 85,
            ),
            RaisedButton(
              color: Colors.green,
              child: Text(
                "Registrar ingresos",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

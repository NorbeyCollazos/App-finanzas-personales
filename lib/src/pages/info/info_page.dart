import 'package:app_finanzas_personales/src/pages/info/info_controller.dart';
import 'package:app_finanzas_personales/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://ncrdesarrollo.com/';

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  InfoController _con = new InfoController();

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
              _bottomAction('assets/img/ic_ingresos.png', 50.0, 150, () {
                _con.goToIngresos();
              }),
              _bottomAction('assets/img/ic_info.png', 35.0, 500, () {}),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              _banerTop(),
              //_banerBottom(),
              _textTitulo(),
              _contentLogoInfo(),
              _contentInfoDesarrollador(),
            ],
          ),
        ));
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

  Widget _banerTop() {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: 230.0,
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
            Text(
              _con.person?.email ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            RaisedButton.icon(
              onPressed: () {
                _con.showAlertDialog();
              },
              icon: Icon(
                FontAwesomeIcons.powerOff,
                color: Colors.white,
              ),
              label: Text(
                "Cerrar sesión",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: utilscolor.Colors.colorAccent,
            )
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
        "Finanzas Personales",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _contentLogoInfo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        children: [
          Image.asset(
            'assets/img/icono.png',
            width: 120,
          ),
          Text("Versión 1.0.0"),
        ],
      ),
    );
  }

  Widget _contentInfoDesarrollador() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        children: [
          Text("Desarrollado por"),
          GestureDetector(
            onTap: () => _launchURL(),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "ncrdesarrollo.com",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void refresh() {
    setState(() {});
  }
}

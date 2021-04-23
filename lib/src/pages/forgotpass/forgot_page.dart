import 'package:app_finanzas_personales/src/pages/forgotpass/forgot_controller.dart';

import 'package:app_finanzas_personales/src/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;

class ForgotPage extends StatefulWidget {
  ForgotPage({Key key}) : super(key: key);

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  ForgotController _con = new ForgotController();

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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _banerLogin(),
            _icono(),
            _textfieldEmail(),
            _buttonForgot(),
          ],
        ),
      ),
    );
  }

  Widget _banerLogin() {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: 150,
        color: utilscolor.Colors.colorPrimary,
        child: Center(
            child: Text(
          "Recuperar contraseña",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        )),
      ),
    );
  }

  Widget _icono() {
    return Image.asset(
      'assets/img/icono.png',
      width: 150.0,
    );
  }

  Widget _textfieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "correo@gmail.com",
          labelText: "Correo electrónico",
          //prefixIcon -> para posicionar icono a l aizquierda
          suffixIcon: Icon(
            Icons.email_outlined,
            color: utilscolor.Colors.colorAccent,
          ),

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

  Widget _buttonForgot() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: () {
          _con.forgotPass();
        },
        text: "Enviar solicitud",
        color: utilscolor.Colors.colorAccent,
      ),
    );
  }
}

import 'package:app_finanzas_personales/src/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _con.key,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _banerLogin(),
            _icono(),
            _textfieldEmail(),
            _textfieldPassword(),
            _buttonLogin(),
            _textNoCuenta(),
          ],
        ),
      ),
    );
  }

  Widget _banerLogin() {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        color: utilscolor.Colors.colorPrimary,
        child: Center(
            child: Text(
          "Finanzas Personales",
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
    return Image.asset('assets/img/icono.png');
  }

  Widget _textfieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        //controller: _con.emailController,
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

  Widget _textfieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        //controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Contraseña",
          //prefixIcon -> para posicionar icono a l aizquierda
          suffixIcon: Icon(
            Icons.lock_open,
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

  Widget _buttonLogin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: () {
          //_con.login();
        },
        text: "Iniciar sesión",
        color: utilscolor.Colors.colorAccent,
      ),
    );
  }

  Widget _textNoCuenta() {
    return GestureDetector(
      //onTap: _con.goToRegister,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¿No tienes cuenta? ",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              "Regístrate",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: utilscolor.Colors.colorAccent,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

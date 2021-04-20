import 'package:app_finanzas_personales/src/pages/register/register_controller.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:app_finanzas_personales/src/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = new RegisterController();
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
            _textfieldUsername(),
            _textfieldEmail(),
            _textfieldPassword(),
            _textfieldConfirmPassword(),
            _buttonRegister(),
          ],
        ),
      ),
    );
  }

  Widget _banerLogin() {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        color: utilscolor.Colors.colorPrimary,
        child: Center(
            child: Text(
          "Registro de usuario",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        )),
      ),
    );
  }

  Widget _textfieldUsername() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.usernameController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: "Nombre y Apellido",
          labelText: "Nombre de usuario",
          //prefixIcon -> para posicionar icono a l aizquierda
          suffixIcon: Icon(
            Icons.person_outline,
            color: utilscolor.Colors.colorAccent,
          ),
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
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
          ),
        ),
      ),
    );
  }

  Widget _textfieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.passwordController,
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
          ),
        ),
      ),
    );
  }

  Widget _textfieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.repeatpasswordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Confirmar contraseña",
          //prefixIcon -> para posicionar icono a l aizquierda
          suffixIcon: Icon(
            Icons.lock_open,
            color: utilscolor.Colors.colorAccent,
          ),
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: () {
          _con.register();
        },
        text: "Registrar ahora",
        color: utilscolor.Colors.colorAccent,
      ),
    );
  }
}

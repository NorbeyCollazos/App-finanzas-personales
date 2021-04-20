import 'package:app_finanzas_personales/src/pages/addgastos/add_gastos_page.dart';
import 'package:app_finanzas_personales/src/pages/gastos/gastos_page.dart';
import 'package:app_finanzas_personales/src/pages/home/home_page.dart';
import 'package:app_finanzas_personales/src/pages/login/login_page.dart';
import 'package:app_finanzas_personales/src/pages/register/register_page.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: utilscolor.Colors.colorPrimary,
        accentColor: utilscolor.Colors.colorAccent,
      ),
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'home': (BuildContext context) => HomePage(),
        'gastos': (BuildContext context) => GastosPage(),
        'addGastos': (BuildContext context) => AddGastosPage(),
      },
    );
  }
}

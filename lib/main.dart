import 'package:app_finanzas_personales/src/pages/addgastos/add_gastos_page.dart';
import 'package:app_finanzas_personales/src/pages/addingresos/add_ingresos_page.dart';
import 'package:app_finanzas_personales/src/pages/detailgastos/detail_gastos_page.dart';
import 'package:app_finanzas_personales/src/pages/detailingresos/detail_ingresos_page.dart';
import 'package:app_finanzas_personales/src/pages/forgotpass/forgot_page.dart';
import 'package:app_finanzas_personales/src/pages/gastos/gastos_page.dart';
import 'package:app_finanzas_personales/src/pages/info/info_page.dart';
import 'package:app_finanzas_personales/src/pages/ingresos/ingresos_page.dart';
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
        primarySwatch: Colors.deepPurple,
      ),
      title: 'Material App',
      initialRoute: 'login',
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          DetailsParams params = settings.arguments;
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return DetailsPage(
                params: params,
              );
            },
          );
        }
        if (settings.name == '/detailsIngresos') {
          DetailsIngresosParams params = settings.arguments;
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return DetailsIngresosPage(
                params: params,
              );
            },
          );
        }
      },
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'forgotpass': (BuildContext context) => ForgotPage(),
        'gastos': (BuildContext context) => GastosPage(),
        'addGastos': (BuildContext context) => AddGastosPage(),
        'ingresos': (BuildContext context) => IngresosPage(),
        'addIngresos': (BuildContext context) => AddIngresosPage(),
        'info': (BuildContext context) => InfoPage(),
      },
    );
  }
}

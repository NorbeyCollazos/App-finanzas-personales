import 'package:app_finanzas_personales/src/pages/login/login_page.dart';
import 'package:app_finanzas_personales/src/utils/colors.dart' as utilscolor;
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
      },
    );
  }
}

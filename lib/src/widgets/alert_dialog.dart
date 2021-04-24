import 'package:flutter/material.dart';

class AlertApp extends StatelessWidget {
  String titulo;
  String texto;
  String textobt1;
  String textobt2;
  Function onPressed;

  AlertApp({
    this.titulo = "Título",
    this.texto = "Texto",
    this.textobt1 = "Aceptar",
    this.textobt2 = "Cancelar",
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: Text(texto),
      actions: [
        FlatButton(
            child: Text(textobt1),
            textColor: Colors.blue,
            onPressed: () {
              Navigator.of(context).pop();
              onPressed();
            }),
        FlatButton(
            child: Text(textobt2),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}

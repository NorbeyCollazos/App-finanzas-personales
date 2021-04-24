import 'package:flutter/material.dart';

class AlertAppDelete extends StatelessWidget {
  String titulo;
  String texto;
  String textobt1;
  String textobt2;
  Function onPressed;

  AlertAppDelete({
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
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              onPressed();
            },
            child: const Text("Eliminar")),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancelar"),
        ),
      ],
    );
  }
}

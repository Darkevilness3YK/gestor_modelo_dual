// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DialogEliminarDualista extends StatelessWidget {
  const DialogEliminarDualista({super.key});

  @override
  Widget build(BuildContext context) {
    void eliminar() => Navigator.of(context).pop(true);
    void cancelar() => Navigator.of(context).pop(false);

    return AlertDialog(
      title: Text("Eliminar dualista"),
      content: Text("¿Estás seguro de querer eliminar a este dualista?\nNOTA: ¡Esta acción es irreversible!"),
      actions: [
        TextButton(
          child: Text("Eliminar", style: TextStyle(color: Colors.red)),
          onPressed: () => eliminar(),
        ),
        TextButton(
          child: Text("Cancelar"),
          onPressed: () => cancelar(),
        ),
      ],
    );
  }
}

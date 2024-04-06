// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DialogEnDesarrollo extends StatelessWidget {
  const DialogEnDesarrollo({super.key});

  @override
  Widget build(BuildContext context) {
    void aceptar() => Navigator.of(context).pop(false);

    return AlertDialog(
      title: Text("En desarrollo"),
      content: Text("Esta característica aún está en desarrollo."),
      actions: [
        TextButton(
          child: Text("Aceptar"),
          onPressed: () => aceptar(),
        ),
      ],
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DialogBuscarDualista extends StatefulWidget {
  const DialogBuscarDualista({super.key});

  @override
  State<DialogBuscarDualista> createState() => _DialogBuscarDualistaState();
}

class _DialogBuscarDualistaState extends State<DialogBuscarDualista> {
  late TextEditingController dialogTextFieldController;

  @override
  void initState() {
    super.initState();
    dialogTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    dialogTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Las siguientes funciones son basadas de: https://www.youtube.com/watch?v=D6icsXS8NeA
    void buscar() => Navigator.of(context).pop(int.parse(dialogTextFieldController.text));
    void cancelar() => Navigator.of(context).pop();
    void limpiarBusqueda() => Navigator.of(context).pop(0);

    return AlertDialog(
      title: Text("Buscar dualista"),
      content: TextField(
        autofocus: true, // Hacer que el TextField ya esté seleccionado para escribir.
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2.0),
          ),
          hintText: "Introduzca una matrícula",
          prefixIcon: Icon(Icons.numbers, size: 16.0),
        ),
        controller: dialogTextFieldController,
      ),
      actions: [
        TextButton(
          child: Text("Limpiar Búsqueda", style: TextStyle(color: Colors.red)),
          onPressed: () => limpiarBusqueda(),
        ),
        TextButton(
          child: Text("Cancelar"),
          onPressed: () => cancelar(),
        ),
        TextButton(
          child: Text("Buscar", style: TextStyle(color: Colors.green)),
          onPressed: () => buscar(),
        ),
      ],
    );
  }
}

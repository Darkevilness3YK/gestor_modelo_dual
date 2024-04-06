// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/views/view_menu_principal.dart';
import 'package:gestor_modelo_dual/widgets/buttons/function_text_button.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    void recargarPagina() {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          // Por el momento, esta función te llevará al menú principal.
          pageBuilder: (context, animation, secondaryAnimation) => ViewMenuPrincipal(),
          // Una animación de 0 segundos tras cambiar de página simulará una recarga de página.
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¡Oh no! :(",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "\nOcurrió un error al intentar obtener información del servidor.\n\nEstamos trabajando para solucionar el problema.\n\nDisculpe las molestias.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 25.0),
        FunctionTextButton(
          backgroundColor: Colors.blue.shade400,
          foregroundColor: Colors.white,
          function: recargarPagina,
          text: "Reintentar",
        ),
      ],
    );
  }
}

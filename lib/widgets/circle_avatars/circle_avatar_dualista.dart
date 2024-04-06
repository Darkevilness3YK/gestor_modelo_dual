// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/models/model_dualista.dart';

class CircleAvatarDualista extends StatelessWidget {
  final Dualista dualista;
  final double? radius;

  const CircleAvatarDualista({super.key, required this.dualista, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: getRandomColor(),
      radius: radius,
      child: Text(
        "${dualista.nombre!.substring(0, 1)}${dualista.apellido!.substring(0, 1)}",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // El color aleatorio es obtenido según la información del dualista, por lo que, teóricamente, cada dualista tendrá un color de avatar único.
  // Rojo: se obtiene con el valor hash del nombre.
  // Verde: se obtiene con el valor hash del apellido.
  // Azul: se obtiene con la matrícula.
  Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random(dualista.matricula).nextInt(255),
      Random(dualista.nombre.hashCode).nextInt(255),
      Random(dualista.apellido.hashCode).nextInt(255),
    );
  }
}

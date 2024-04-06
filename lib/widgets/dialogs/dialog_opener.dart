// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/widgets/dialogs/dialog_buscar_dualista.dart';
import 'package:gestor_modelo_dual/widgets/dialogs/dialog_eliminar_dualista.dart';
import 'package:gestor_modelo_dual/widgets/dialogs/dialog_en_desarrollo.dart';

// Esta clase contendrá métodos para abrir cada uno de los AlertDialog dentro de la carpeta "dialogs".
// Los métodos para abrir los dialogs son del tipo "openNombreDialog()".
class DialogOpener {
  late BuildContext context;

  // El constructor requiere, obligatoriamente, el BuildContext del Widget donde se desea abrir algún Dialog.
  DialogOpener({
    required this.context,
  });

  // Abrirá el AlertDialog para búsqueda de dualistas.
  // El Future<int?> se debe a que, al presionar "buscar", se devolverá un valor entero (no será de inmediato); en este caso, se devolverá una matrícula dada por el usuario, aunque puede no devolverse nada si el usuario cancela la operación.
  Future<int?> openBuscarDualistaDialog() {
    return showDialog<int>(
      barrierDismissible: false,
      context: context,
      builder: (context) => DialogBuscarDualista(),
    );
  }

  Future<bool?> openEliminarDualistaDialog() {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => DialogEliminarDualista(),
    );
  }

  Future<void> openEnDesarrolloDialog() {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => DialogEnDesarrollo(),
    );
  }
}

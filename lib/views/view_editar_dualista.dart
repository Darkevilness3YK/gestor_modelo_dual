// ignore_for_file: prefer_const_constructorser_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/apis/dualistas/api_dualistas.dart';
import 'package:gestor_modelo_dual/models/model_dualista.dart';
import 'package:gestor_modelo_dual/providers/provider_operation_message.dart';
import 'package:gestor_modelo_dual/views/view_menu_principal.dart';
import 'package:gestor_modelo_dual/views/view_perfil_dualista.dart';
import 'package:gestor_modelo_dual/widgets/buttons/function_text_button.dart';
import 'package:gestor_modelo_dual/widgets/forms/dualista_form.dart';
import 'package:gestor_modelo_dual/widgets/shared/layout.dart';
import 'package:provider/provider.dart';

class ViewEditarDualista extends StatefulWidget {
  final Dualista dualistaAModificar;

  const ViewEditarDualista({
    super.key,
    required this.dualistaAModificar,
  });

  @override
  State<ViewEditarDualista> createState() => _ViewEditarDualistaState();
}

class _ViewEditarDualistaState extends State<ViewEditarDualista> {
  final GlobalKey<FormState> _editarDualistaFormKey = GlobalKey<FormState>();

  void editarDualista() async {
    if (_editarDualistaFormKey.currentState!.validate()) {
      _editarDualistaFormKey.currentState!.save();

      try {
        Response respuesta = await ApiDualistas().updateDualista(widget.dualistaAModificar);

        if (respuesta.statusCode != 204) {
          throw Exception();
        }

        // ¿Por qué se usó context.mounted para usar Navigator? context.mounted se usa para asegurarte de que tu widget todavía está en la pantalla antes de hacer algo después de una operación asíncrona (podrías salir de la pantalla antes de que la operación asíncrona termine, lo que causaría errores).
        if (context.mounted) {
          // Recarga ListaDualistasView() y DualistaProfile() para mostra la información actualizada del dualista.
          context.read<ProviderOperationMessage>().setOperationMessage("Dualista editado exitosamente.", true);

          // Ir hasta la primera ruta (en este caso, el menú principal con la lista de Dualistas).
          Navigator.of(context).popUntil((route) => route.isFirst);

          // Recargar la primera ruta (reemplazarlo por el mismo Widget, lo que actualizará la lista de Dualistas al hacer otra petición a la API).
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ViewMenuPrincipal()),
          );

          // Volver a la vista Perfil Dualista con la información ya actualizada.
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ViewPerfilDualista(dualista: widget.dualistaAModificar)),
          );
        }
      } on Exception {
        if (context.mounted) {
          context
              .read<ProviderOperationMessage>()
              .setOperationMessage("Ocurrió un error al editar al dualista.", false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Editar dualista",
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Inserte los nuevos datos del dualista a continuación.",
                textAlign: TextAlign.center,
              ),
              DualistaForm(
                formKey: _editarDualistaFormKey,
                dualista: widget.dualistaAModificar,
              ),
              FunctionTextButton(
                backgroundColor: Colors.green.shade400,
                foregroundColor: Colors.white,
                function: editarDualista,
                text: "Guardar cambios",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructorser_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/apis/dualistas/api_dualistas.dart';
import 'package:gestor_modelo_dual/models/model_dualista.dart';
import 'package:gestor_modelo_dual/providers/provider_operation_message.dart';
import 'package:gestor_modelo_dual/views/view_menu_principal.dart';
import 'package:gestor_modelo_dual/widgets/buttons/function_text_button.dart';
import 'package:gestor_modelo_dual/widgets/forms/dualista_form.dart';
import 'package:gestor_modelo_dual/widgets/shared/layout.dart';
import 'package:provider/provider.dart';

class ViewAgregarDualista extends StatefulWidget {
  const ViewAgregarDualista({super.key});

  @override
  State<ViewAgregarDualista> createState() => _ViewAgregarDualistaState();
}

class _ViewAgregarDualistaState extends State<ViewAgregarDualista> {
  final GlobalKey<FormState> _agregarDualistaFormKey = GlobalKey<FormState>();
  Dualista nuevoDualista = Dualista.nuevo();

  void agregarDualista() async {
    if (_agregarDualistaFormKey.currentState!.validate()) {
      _agregarDualistaFormKey.currentState!.save();

      try {
        Response respuesta = await ApiDualistas().createDualista(nuevoDualista);

        if (respuesta.statusCode != 201) {
          throw Exception();
        }

        // ¿Por qué se usó context.mounted para usar Navigator? context.mounted se usa para asegurarte de que tu widget todavía está en la pantalla antes de hacer algo después de una operación asíncrona (podrías salir de la pantalla antes de que la operación asíncrona termine, lo que causaría errores).
        if (context.mounted) {
          // Primero actualiza el estado global operationMessage para mostrar que el dualista fue agregado exitosamente.
          context.read<ProviderOperationMessage>().setOperationMessage("Dualista agregado exitosamente.", true);
          // Regresa a la página anterior (ListaDuaistasView) y la reemplaza por la misma página (es decir, la recarga) para que el dualista agregado aparezca.
          Navigator.of(context).pop();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewMenuPrincipal()));
        }
      } on Exception {
        if (context.mounted) {
          context
              .read<ProviderOperationMessage>()
              .setOperationMessage("Ocurrió un error al agregar al dualista.", false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Agregar dualista",
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Inserte los datos del dualista a agregar a continuación.",
                textAlign: TextAlign.center,
              ),
              DualistaForm(
                formKey: _agregarDualistaFormKey,
                dualista: nuevoDualista,
              ),
              FunctionTextButton(
                  backgroundColor: Colors.green.shade400,
                  foregroundColor: Colors.white,
                  function: agregarDualista,
                  text: "Agregar Dualista"),
            ],
          ),
        ),
      ),
    );
  }
}

// class FormCampoNombre extends StatelessWidget {
//   const FormCampoNombre({super.key});

//   String? _validateNombre(String nombre) {
//     if (nombre.isEmpty) return "El campo nombre es requerido.";
//     if (!regExpSoloLetras.hasMatch(nombre)) return "El nombre solo puede contener letras.";
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         hintText: "Nombre",
//         border: OutlineInputBorder(),
//         labelText: "Nombre",
//       ),
//       validator: (nombre) => _validateNombre(nombre!),
//     );
//   }
// }

// class FormCampoApellido extends StatelessWidget {
//   const FormCampoApellido({super.key});

//   String? _validateApellido(String apellido) {
//     if (apellido.isEmpty) return "El campo apellido es requerido.";
//     if (!regExpSoloLetras.hasMatch(apellido)) return "El apellido solo puede contener letras.";
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         hintText: "Apellido",
//         border: OutlineInputBorder(),
//         labelText: "Apellido",
//       ),
//       validator: (apellido) => _validateApellido(apellido!),
//     );
//   }
// }

// class FormCampoSemestre extends StatelessWidget {
//   const FormCampoSemestre({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SpinBox(
//       min: 7,
//       max: 9,
//       value: 7,
//       decoration: InputDecoration(labelText: "Semestre"),
//     );
//   }
// }

// class FormCampoCapacitado extends StatefulWidget {
//   const FormCampoCapacitado({super.key});

//   @override
//   State<FormCampoCapacitado> createState() => _FormCampoCapacitadoState();
// }

// class _FormCampoCapacitadoState extends State<FormCampoCapacitado> {
//   bool seleccionado = false;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox(
//           value: seleccionado,
//           onChanged: (value) => {setState(() => seleccionado = value!)},
//         ),
//         Text("¿Capacitado?"),
//       ],
//     );
//   }
// }

// class BotonAgregarDualista extends StatelessWidget {
//   final GlobalKey<FormState> formKey;

//   const BotonAgregarDualista({super.key, required this.formKey});

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade400),
//         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//       ),
//       onPressed: () {
//         if (formKey.currentState!.validate()) {
//           formKey.currentState!.save();
//           print("Nombre: ");
//           Navigator.pop(context);
//         }
//       },
//       child: Text("Agregar Dualista"),
//     );
//   }
// }

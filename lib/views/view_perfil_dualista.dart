// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/apis/dualistas/api_dualistas.dart';
import 'package:gestor_modelo_dual/models/model_dualista.dart';
import 'package:gestor_modelo_dual/providers/provider_operation_message.dart';
import 'package:gestor_modelo_dual/views/view_editar_dualista.dart';
import 'package:gestor_modelo_dual/views/view_menu_principal.dart';
import 'package:gestor_modelo_dual/widgets/animated_page_routes/animated_page_route_slide/animated_page_route_slide_animation.dart';
import 'package:gestor_modelo_dual/widgets/animated_page_routes/animated_page_route_slide/enum_slide_directions.dart';
import 'package:gestor_modelo_dual/widgets/buttons/function_text_button.dart';
import 'package:gestor_modelo_dual/widgets/circle_avatars/circle_avatar_dualista.dart';
import 'package:gestor_modelo_dual/widgets/dialogs/dialog_opener.dart';
import 'package:gestor_modelo_dual/widgets/shared/layout.dart';
import 'package:provider/provider.dart';

class ViewPerfilDualista extends StatelessWidget {
  final Dualista dualista;

  const ViewPerfilDualista({
    super.key,
    required this.dualista,
  });

  @override
  Widget build(BuildContext context) {
    void regresarMenuPrincipal() => Navigator.of(context).pop();

    void abrirEditarDualista() {
      Navigator.push(
        context,
        //MaterialPageRoute(builder: (context) => ViewEditarDualista(dualistaAModificar: dualista)),
        AnimatedPageRouteSlide(
          page: ViewEditarDualista(dualistaAModificar: dualista),
          slideDirection: SlideDirection.bottomToTop,
        ),
      );
    }

    void eliminarDualista() async {
      final bool? confirmarEliminacion = await DialogOpener(context: context).openEliminarDualistaDialog();

      if (confirmarEliminacion != true) return;

      try {
        Response respuesta = await ApiDualistas().deleteDualista(dualista);

        if (respuesta.statusCode != 204) {
          throw Exception();
        }

        if (context.mounted) {
          // Regresa a la página anterior (ListaDuaistasView) y la reemplaza por la misma página (es decir, la recarga) para que el dualista agregado aparezca.
          context.read<ProviderOperationMessage>().setOperationMessage("Dualista eliminado exitosamente.", true);
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            //MaterialPageRoute(builder: (context) => ViewMenuPrincipal()),
            AnimatedPageRouteSlide(
              page: ViewMenuPrincipal(),
              slideDirection: SlideDirection.leftToRight,
            ),
          );
        }
      } on Exception {
        if (context.mounted) {
          context
              .read<ProviderOperationMessage>()
              .setOperationMessage("Ocurrió un error al eliminar al dualista.", false);
        }
      }
    }

    return Layout(
      title: "Matrícula: ${dualista.matricula}",
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150.0,
                    child: FittedBox(
                      child: CircleAvatarDualista(dualista: dualista),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${dualista.nombre} ${dualista.apellido}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${dualista.semestre}° semestre",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Dualista" "${dualista.capacitado! ? "" : " no"} capacitado",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Los botones más utilizados están más abajo por temas de comodidad; los menos usados están más arriba.
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FunctionTextButton(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        function: eliminarDualista,
                        text: "Eliminar",
                      ),
                      FunctionTextButton(
                        backgroundColor: Colors.green.shade400,
                        foregroundColor: Colors.white,
                        function: abrirEditarDualista,
                        text: "Editar",
                      ),
                      FunctionTextButton(
                        backgroundColor: Colors.blue.shade400,
                        foregroundColor: Colors.white,
                        function: regresarMenuPrincipal,
                        text: "Volver",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/models/model_dualista.dart';
import 'package:gestor_modelo_dual/views/view_perfil_dualista.dart';
import 'package:gestor_modelo_dual/widgets/circle_avatars/circle_avatar_dualista.dart';
import 'package:gestor_modelo_dual/widgets/animated_page_routes/animated_page_route_slide/animated_page_route_slide_animation.dart';
import 'package:gestor_modelo_dual/widgets/animated_page_routes/animated_page_route_slide/enum_slide_directions.dart';

class CardDualistaListTile extends StatelessWidget {
  final Dualista dualista;

  const CardDualistaListTile({super.key, required this.dualista});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatarDualista(dualista: dualista),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey.shade500,
      ),
      title: Text(
        "${dualista.nombre} ${dualista.apellido} (#${dualista.matricula})",
        style: TextStyle(color: dualista.capacitado! ? Colors.blue.shade900 : Colors.black),
      ),
      subtitle: Text("${dualista.semestre}° semestre"),
      onTap: () {
        Navigator.of(context).push(
          // MaterialPageRoute(builder: (context) => ViewPerfilDualista(dualista: dualista)),
          AnimatedPageRouteSlide(
            page: ViewPerfilDualista(dualista: dualista),
            slideDirection: SlideDirection.rightToLeft,
          ),
        );
      },
    );
  }
}

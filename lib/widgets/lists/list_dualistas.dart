// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/apis/dualistas/api_dualistas.dart';
import 'package:gestor_modelo_dual/models/model_dualista.dart';
import 'package:gestor_modelo_dual/widgets/buttons/function_text_button.dart';
import 'package:gestor_modelo_dual/widgets/cards/card_dualista_list_tile.dart';
import 'package:gestor_modelo_dual/widgets/shared/error_message.dart';

class ListDualistas extends StatelessWidget {
  final int dualistaMatricula;
  final VoidCallback? funcionLimpiarBusqueda;
  const ListDualistas({
    super.key,
    required this.dualistaMatricula,
    this.funcionLimpiarBusqueda,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Dualista>>(
      // Obtención de datos (consulta a la API).
      // Esperará un máximo de 10 segundos; si no hay respuesta, se lanzará un error.
      future: (dualistaMatricula == 0)
          ? ApiDualistas().getAllDualistas().timeout(Duration(seconds: 10))
          : ApiDualistas().getDualistaByMatricula(dualistaMatricula).timeout(Duration(seconds: 10)),
      initialData: const [], // Valor de "future" mientras se obtienen los datos.
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Mientras se obtienen los datos, se muestra un loader.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue.shade400,
              strokeWidth: 6.0,
            ),
          );
        }

        // Si hubo un error al obtener los datos, mostrar un error.
        else if (snapshot.hasError) {
          //return Text("F, algo salió mal :( \nDetalles: ${snapshot.error} \n${snapshot.stackTrace}");
          return Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: ErrorMessage(),
            ),
          );
        }

        // Si los datos se obtuvieron exitosamente, crear una lista de los datos obtenidos.
        List<Dualista> listaDualistas = snapshot.data;
        if (listaDualistas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Text(
                    "No se encontró un dualista con matrícula $dualistaMatricula.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child: FunctionTextButton(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    function: funcionLimpiarBusqueda ?? () {},
                    text: "Limpiar búsqueda",
                  ),
                )
              ],
            ),
          );
        }
        return ListView.builder(
          // El +1 es para que, tras el último dualista, se muestre el botón Limpiar Búsqueda (en caso de que se haya realizado una búsqueda).
          itemCount: listaDualistas.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index < listaDualistas.length) {
              return CardDualistaListTile(dualista: listaDualistas[index]);
            } else {
              // La visibilidad del botón Limpiar Búsqueda dependerá del valor de dualistaMatricula.
              // Una matrícula = 0 implica que no hay una búsqueda y que, por lo tanto, todos los dualistas van a mostrarse.
              //Una matrícula != 0 implica una búsqueda, y solo el dualista con la matrícula especificada se mostrará.
              return Visibility(
                visible: dualistaMatricula != 0 ? true : false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child: FunctionTextButton(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    function: funcionLimpiarBusqueda ?? () {},
                    text: "Limpiar búsqueda",
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

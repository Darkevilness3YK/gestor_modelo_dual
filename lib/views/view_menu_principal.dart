// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/views/view_agregar_dualista.dart';
import 'package:gestor_modelo_dual/widgets/animated_page_routes/animated_page_route_slide/animated_page_route_slide_animation.dart';
import 'package:gestor_modelo_dual/widgets/animated_page_routes/animated_page_route_slide/enum_slide_directions.dart';
import 'package:gestor_modelo_dual/widgets/dialogs/dialog_opener.dart';
import 'package:gestor_modelo_dual/widgets/lists/list_dualistas.dart';
import 'package:gestor_modelo_dual/widgets/shared/layout.dart';

class ViewMenuPrincipal extends StatefulWidget {
  const ViewMenuPrincipal({super.key});

  @override
  State<ViewMenuPrincipal> createState() => _ViewMenuPrincipalState();
}

class _ViewMenuPrincipalState extends State<ViewMenuPrincipal> {
  final GlobalKey overlayKey = GlobalKey();
  int dualistaMatricula = 0;

  void abrirBuscarDualista() async {
    final int? matriculaObtenida = await DialogOpener(context: context).openBuscarDualistaDialog();
    if (matriculaObtenida == null) return;
    setState(() => dualistaMatricula = matriculaObtenida);
  }

  void abrirConfiguracion() async {
    await DialogOpener(context: context).openEnDesarrolloDialog();
  }

  void limpiarBusqueda() {
    setState(() => dualistaMatricula = 0);
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold de la vista
    return Layout(
      title: "Lista de dualistas",
      body: ListDualistas(
        dualistaMatricula: dualistaMatricula,
        funcionLimpiarBusqueda: limpiarBusqueda,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 32.0),
        onPressed: () {
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => ViewAgregarDualista()),
            AnimatedPageRouteSlide(
              page: ViewAgregarDualista(),
              slideDirection: SlideDirection.bottomToTop,
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade400,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: "Configuración",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: "Buscar dualista",
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          switch (index) {
            case 0:
              abrirConfiguracion();
              break;
            case 1:
              abrirBuscarDualista();
              break;
          }
        },
      ),
    );
  }
}

// FloatingActionButton para navegación (obsoleto) //
// floatingActionButtonLocation: ExpandableFab.location,
// floatingActionButton: ExpandableFab(
//   overlayStyle: ExpandableFabOverlayStyle(color: Color.fromARGB(127, 0, 0, 0)),
//   distance: 60.0,
//   type: ExpandableFabType.up,
//   children: [
//     FloatingActionButton.small(
//       heroTag: null,
//       tooltip: "Buscar dualista",
//       child: const Icon(Icons.search),
//       // En el botón buscar, se estará esperando el valor entero en openSearchDialog(), que es una matrícula.
//       onPressed: () async {
//         final int? matriculaObtenida = await DialogOpener(context: context).openBuscarDualistaDialog();
//         if (matriculaObtenida == null) return;
//         setState(() => dualistaMatricula = matriculaObtenida);
//       },
//     ),
//     FloatingActionButton.small(
//       heroTag: null,
//       tooltip: "Agregar dualista",
//       child: const Icon(Icons.add),
//       onPressed: () {
//         Navigator.push(
//           context,
//           //MaterialPageRoute(builder: (context) => ViewAgregarDualista()),
//           CustomAnimatedPageRouteSlide(
//             page: ViewAgregarDualista(),
//             slideDirection: SlideDirection.bottomToTop,
//           ),
//         );
//       },
//     ),
//     FloatingActionButton.small(
//       heroTag: null,
//       tooltip: "Configuración",
//       child: const Icon(Icons.settings),
//       onPressed: () {},
//     ),
//   ],
// ),

// Antigua API//

// return FutureBuilder<Dualistas>(
//   future: ApiDualistas().getAllDualistas(),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       Text("Loading...");
//     } else if (snapshot.hasError) {
//       return Text("Error :(");
//     } else {
//       Dualistas? lista = snapshot.data;
//       return Card(
//         child: ListTile(
//           title: Text("${lista!.nombre} ${lista.apellido}"),
//           subtitle: Text("${lista.semestre}"),
//         ),
//       );
//     }
//   }
// );

// ListView.builder(
//   itemBuilder: (BuildContext context, int index) {
//     return Text("XD");
//   },
//   itemCount: 10,
// ),

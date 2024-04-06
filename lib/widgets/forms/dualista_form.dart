// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:gestor_modelo_dual/models/model_dualista.dart';

class DualistaForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Dualista dualista;

  const DualistaForm({
    super.key,
    required this.formKey,
    required this.dualista,
  });

  @override
  State<DualistaForm> createState() => _DualistaFormState();
}

class _DualistaFormState extends State<DualistaForm> {
  RegExp regExpOnlyLettersAndSpaces = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñÜüÖö\s]+$');
  RegExp regExpOnlyNumbers = RegExp(r'^[0-9]+$');

  String? _validateIntField(int? integer, String fieldName) {
    if (integer == null) return "El campo $fieldName es requerido.";
    if (!regExpOnlyNumbers.hasMatch(integer.toString())) return "El $fieldName solo puede contener números.";
    return null;
  }

  String? _validateStringField(String string, String fieldName) {
    if (string.isEmpty) return "El campo $fieldName es requerido.";
    if (!regExpOnlyLettersAndSpaces.hasMatch(string)) return "El $fieldName solo puede contener letras y espacios.";
    return null;
  }

  final StreamController<bool> _checkBoxController = StreamController();
  Stream<bool> get _checkBoxStream => _checkBoxController.stream;

  @override
  void dispose() {
    _checkBoxController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Para que cada TextFormField tenga un color personalizado cada vez que tengan focus, se tomó código y soluciones de: https://stackoverflow.com/questions/56411599/flutter-textformfield-change-labelcolor-on-focus
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Visibility(
            visible: widget.dualista.matricula == 0 ? false : true,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025),
              child: TextFormField(
                controller: TextEditingController(text: widget.dualista.matricula.toString()),
                decoration: InputDecoration(
                  hintText: "Matricula",
                  labelText: "Matricula",
                ),
                readOnly: true,
                validator: (matricula) => _validateIntField(int.parse(matricula!), "matricula"),
                onSaved: (matricula) => widget.dualista.matricula = int.parse(matricula!),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025),
            child: TextFormField(
              controller: TextEditingController(text: widget.dualista.nombre),
              decoration: InputDecoration(
                hintText: "Nombre",
                labelText: "Nombre",
              ),
              validator: (nombre) => _validateStringField(nombre!, "nombre"),
              onSaved: (nombre) => widget.dualista.nombre = nombre!,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025),
            child: TextFormField(
              controller: TextEditingController(text: widget.dualista.apellido),
              decoration: InputDecoration(
                hintText: "Apellido",
                labelText: "Apellido",
              ),
              validator: (apellido) => _validateStringField(apellido!, "apellido"),
              onSaved: (apellido) => widget.dualista.apellido = apellido!,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025),
            child: SpinBox(
              min: 7,
              max: 9,
              value: double.parse(widget.dualista.semestre!),
              decoration: InputDecoration(
                labelText: "Semestre",
              ),
              onChanged: (semestre) => widget.dualista.semestre = semestre.round().toString(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025),
            child: Row(
              children: [
                // Para hacer que el checkbox sea utilizado sin setState() para no alterar la información del dualista, se tomó código de https://levelup.gitconnected.com/flutter-checkbox-without-setstate-ec8181cda32f
                StreamBuilder(
                  stream: _checkBoxStream,
                  initialData: false,
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return Checkbox(
                      value: widget.dualista.capacitado,
                      onChanged: (value) {
                        _checkBoxController.sink.add(value!);
                        widget.dualista.capacitado = value;
                      },
                    );
                  },
                ),
                Text("¿Capacitado?"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

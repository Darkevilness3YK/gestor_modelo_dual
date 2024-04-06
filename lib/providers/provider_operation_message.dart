// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

class ProviderOperationMessage with ChangeNotifier {
  String _operationMessage = "";
  Color _operationMessageColor = Colors.transparent;
  bool _operationContainerVisible = false;
  int _secondsElapsed = 0;
  Timer? _fadeOperationMessageContainerTimer;

  AnimatedOpacity get operationMessageContainer {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      opacity: _operationContainerVisible ? 1.0 : 0.0,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          color: _operationMessageColor,
          child: Text(
            _operationMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Temporizador que incrementa _secondsElapsed en 1 cada segundo.
  // Si una variable de tipo Timer obtiene el valor de esta función, automáticamente el timer comienza a correr.
  Timer getFadeOperationContainerTimer() {
    return Timer.periodic(Duration(seconds: 1), (Timer t) {
      // print(_secondsElapsed);
      _secondsElapsed++;

      if (_secondsElapsed > 4) {
        _operationContainerVisible = false;
        _secondsElapsed = 0;
        t.cancel(); // Parar el temporizador cuando _secondsElapsed > 4.
        notifyListeners(); // Hacer que desaparezca operationMessageContainer en tiempo real.
      }
    });
  }

  void setOperationMessage(String operationMessage, bool wasOperationSuccessful) {
    _operationMessage = operationMessage;
    _operationMessageColor = wasOperationSuccessful ? Colors.green : Colors.red;
    _operationContainerVisible = true;
    notifyListeners(); // Hacer que aparezca operationMessageContainer en tiempo real.

    // Si el timer aún no ha sido inicializado o los segundos están en 0, se reinicia el timer.
    if (_fadeOperationMessageContainerTimer == null || _secondsElapsed == 0) {
      //print("A");
      _secondsElapsed = 0;
      _fadeOperationMessageContainerTimer = getFadeOperationContainerTimer();
    } else {
      // Si el timer ya había sido iniciado, pero el mensaje de operación se actualiza, la cuenta se interrumpe y se
      // reinicia nuevamente.
      if (_fadeOperationMessageContainerTimer!.isActive) {
        //print("B");
        _fadeOperationMessageContainerTimer!.cancel();
        _secondsElapsed = 0;
        _fadeOperationMessageContainerTimer = getFadeOperationContainerTimer();
      }
    }
  }
}

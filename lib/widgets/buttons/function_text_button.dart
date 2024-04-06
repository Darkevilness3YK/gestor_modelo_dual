// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Botón creado por mi.
class FunctionTextButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback function;
  final String text;

  const FunctionTextButton({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.function,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 50.0,
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
        ),
        onPressed: function,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/providers/provider_operation_message.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  final String title;
  final Widget body;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const Layout({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    // final GlobalKey overlayKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(children: [
        widget.body,
        context.watch<ProviderOperationMessage>().operationMessageContainer,
      ]),
      // Botón flotante
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}

/*
Overlay(
  key: overlayKey,
  initialEntries: [
    OverlayEntry(
      builder: (context) => Text(
        "Hola",
        textAlign: TextAlign.center,
        style: TextStyle(backgroundColor: Colors.green),
      ),
    ),
  ],
),

Overlay(
  key: overlayKey,
  initialEntries: [
    OverlayEntry(
      builder: (context) => Text(
        context.watch<ProviderOperationMessage>().operationMessage.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(backgroundColor: context.watch<ProviderOperationMessage>().operationMessageColor),
      ),
    ),
  ],
),
*/
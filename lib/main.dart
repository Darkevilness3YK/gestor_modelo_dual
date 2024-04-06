// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/providers/provider_operation_message.dart';
import 'package:gestor_modelo_dual/views/view_menu_principal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProviderOperationMessage(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor Modelo Dual',
      home: Scaffold(
        body: ViewMenuPrincipal(),
      ),
      // Código para ThemeData obtenido de https://codingwithrashid.com/how-to-change-selection-color-of-text-in-flutter/
      // Desde aquí se puede cambiar el color para todos los Widgets de texto, checkbox, botones, etc.
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Código obtenido de https://docs.flutter.dev/release/breaking-changes/toggleable-active-color#migration-guide.
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return Colors.blue.shade700;
            }
            return null;
          }),
        ),
        focusColor: Colors.blue.shade700,
        // Código obtenido de ChatGPT. Esta parte afecta a aquellos componentes que requieren inputs, especialmente los formularios.
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2.0),
          ),
          floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.focused) ? Colors.blue.shade700 : Colors.grey.shade700;
            return TextStyle(color: color);
          }),
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.blue.shade700),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade700)),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue.shade700,
          selectionColor: Colors.lightBlue.shade100,
          selectionHandleColor: Colors.blue.shade700,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.openSans(fontWeight: FontWeight.w600),
          displayMedium: GoogleFonts.openSans(fontWeight: FontWeight.w600),
          displaySmall: GoogleFonts.openSans(fontWeight: FontWeight.w600),
          titleLarge: GoogleFonts.openSans(fontWeight: FontWeight.w700),
          titleMedium: GoogleFonts.openSans(fontWeight: FontWeight.w600),
          titleSmall: GoogleFonts.openSans(fontWeight: FontWeight.w600),
          bodyLarge: GoogleFonts.openSans(),
          bodyMedium: GoogleFonts.openSans(),
          bodySmall: GoogleFonts.openSans(),
        ),
      ),
    );
  }
}

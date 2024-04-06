import 'package:flutter/material.dart';
import 'api_dualistas.dart';

class ApiDualistasConsumer extends StatefulWidget {
  const ApiDualistasConsumer({super.key});

  @override
  State<ApiDualistasConsumer> createState() => _ApiDualistasConsumerState();
}

class _ApiDualistasConsumerState extends State<ApiDualistasConsumer> {
  @override
  void initState() {
    super.initState();
    // ApiDualistas().getAllDualistas();
    ApiDualistas().getDualistaByMatricula(3);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

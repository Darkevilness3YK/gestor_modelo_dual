import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GetUsers extends StatefulWidget {
  const GetUsers({super.key});

  @override
  State<GetUsers> createState() => _GetUsersState();
}

class _GetUsersState extends State<GetUsers> {
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/users');
    var response = await get(url);
    var data = jsonDecode(response.body);

    // ignore: avoid_print
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

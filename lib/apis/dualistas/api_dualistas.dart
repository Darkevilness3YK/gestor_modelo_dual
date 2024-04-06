import 'package:dio/dio.dart';
import 'package:gestor_modelo_dual/models/model_dualista.dart';

// Los datos se guardarán de la siguiente forma:
// print("${data[0]["nombre"]}");
// print("${response.data}");
class ApiDualistas {
  Future<List<Dualista>> getAllDualistas() async {
    try {
      //String apiUrl = "http://localhost:5189/api/Dualistas/"; <-- Endpoint original (fuera de Android Studio).
      String apiUrl = "http://10.0.2.2:5189/api/Dualistas/";
      Response response = await Dio().get(apiUrl);
      List<dynamic> data = response.data;
      return data.map<Dualista>(Dualista.fromJson).toList();
    } on Exception {
      rethrow;
    }
  }

  Future<List<Dualista>> getDualistaByMatricula(int matricula) async {
    try {
      String apiUrl = "http://10.0.2.2:5189/api/Dualistas/$matricula";
      Response response = await Dio().get(apiUrl);
      List<dynamic> data = response.data;
      return data.map<Dualista>(Dualista.fromJson).toList();
    } on Exception {
      rethrow;
    }
  }

  // Basado de: https://www.youtube.com/watch?v=r_3LeoGNS6c
  Future<Response> createDualista(Dualista dualista) async {
    try {
      String apiUrl = "http://10.0.2.2:5189/api/Dualistas/";
      Response response = await Dio().post(
        apiUrl,
        data: {
          "nombre": dualista.nombre,
          "apellido": dualista.apellido,
          "semestre": dualista.semestre,
          "capacitado": dualista.capacitado,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  // Basado de: https://www.youtube.com/watch?v=r_3LeoGNS6c
  Future<Response> updateDualista(Dualista dualista) async {
    try {
      String apiUrl = "http://10.0.2.2:5189/api/Dualistas/${dualista.matricula}";
      Response response = await Dio().put(
        apiUrl,
        data: {
          "matricula": dualista.matricula,
          "nombre": dualista.nombre,
          "apellido": dualista.apellido,
          "semestre": dualista.semestre,
          "capacitado": dualista.capacitado,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> deleteDualista(Dualista dualista) async {
    try {
      String apiUrl = "http://10.0.2.2:5189/api/Dualistas/${dualista.matricula}";
      Response response = await Dio().delete(apiUrl);
      return response;
    } on Exception {
      rethrow;
    }
  }
}

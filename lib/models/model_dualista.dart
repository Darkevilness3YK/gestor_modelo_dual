class Dualista {
  late int? matricula;
  late String? nombre;
  late String? apellido;
  late String? semestre;
  late bool? capacitado;

  Dualista({
    required this.matricula,
    required this.nombre,
    required this.apellido,
    required this.semestre,
    required this.capacitado,
  });

  // Este método usará el constructor Dualista para crear un objeto Dualista nuevo (con datos por defecto).
  static Dualista nuevo() {
    return Dualista(
      matricula: 0,
      nombre: "",
      apellido: "",
      semestre: "7",
      capacitado: false,
    );
  }

  // Este método usará el constructor Dualista para crear un objeto Dualista con datos obtenidos de un JSON.
  static Dualista fromJson(json) {
    return Dualista(
      matricula: json["matricula"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      semestre: json["semestre"],
      capacitado: json["capacitado"],
    );
  }
}

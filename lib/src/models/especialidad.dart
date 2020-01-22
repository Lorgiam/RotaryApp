import 'dart:convert';

List<Especialidad> especialidadFromJson(String str) => List<Especialidad>.from(
    json.decode(str).map((x) => Especialidad.fromJson(x)));

String especialidadToJson(List<Especialidad> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Especialidad {
  int id;
  String nombreEspecialidad;
  int idProfesion;

  Especialidad({
    this.id,
    this.nombreEspecialidad,
    this.idProfesion,
  });

  Especialidad copyWith({
    int id,
    String nombreEspecialidad,
    int idProfesion,
  }) =>
      Especialidad(
        id: id ?? this.id,
        nombreEspecialidad: nombreEspecialidad ?? this.nombreEspecialidad,
        idProfesion: idProfesion ?? this.idProfesion,
      );

  factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
        id: json["id"] == null ? null : json["id"],
        nombreEspecialidad: json["nombreEspecialidad"] == null
            ? null
            : json["nombreEspecialidad"],
        idProfesion: json["idProfesion"] == null ? null : json["idProfesion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombreEspecialidad":
            nombreEspecialidad == null ? null : nombreEspecialidad,
        "idProfesion": idProfesion == null ? null : idProfesion,
      };
}

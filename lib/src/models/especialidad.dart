// To parse this JSON data, do
//
//     final especialidad = especialidadFromJson(jsonString);

import 'dart:convert';

List<Especialidad> especialidadFromJson(String str) => List<Especialidad>.from(json.decode(str).map((x) => Especialidad.fromJson(x)));

String especialidadToJson(List<Especialidad> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Especialidad {
    int idEspecialidad;
    String nombreEspecialidad;
    int profesion;

    Especialidad({
        this.idEspecialidad,
        this.nombreEspecialidad,
        this.profesion,
    });

    Especialidad copyWith({
        int idEspecialidad,
        String nombreEspecialidad,
        int profesion,
    }) => 
        Especialidad(
            idEspecialidad: idEspecialidad ?? this.idEspecialidad,
            nombreEspecialidad: nombreEspecialidad ?? this.nombreEspecialidad,
            profesion: profesion ?? this.profesion,
        );

    factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
        idEspecialidad: json["idEspecialidad"] == null ? null : json["idEspecialidad"],
        nombreEspecialidad: json["nombreEspecialidad"] == null ? null : json["nombreEspecialidad"],
        profesion: json["profesion"] == null ? null : json["profesion"],
    );

    Map<String, dynamic> toJson() => {
        "idEspecialidad": idEspecialidad == null ? null : idEspecialidad,
        "nombreEspecialidad": nombreEspecialidad == null ? null : nombreEspecialidad,
        "profesion": profesion == null ? null : profesion,
    };
}

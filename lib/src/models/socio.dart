// To parse this JSON data, do
//
//     final socio = socioFromJson(jsonString);

import 'dart:convert';

List<Socio> socioFromJson(String str) => List<Socio>.from(json.decode(str).map((x) => Socio.fromJson(x)));

String socioToJson(List<Socio> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Socio {
    int id;
    String numeroCedula;
    String nombreCompleto;
    String correoElectronico;
    String celular;
    DateTime fechaNacimiento;
    int informacionComercial;
    int club;
    int especialidad;
    int usuario;

    Socio({
        this.id,
        this.numeroCedula,
        this.nombreCompleto,
        this.correoElectronico,
        this.celular,
        this.fechaNacimiento,
        this.informacionComercial,
        this.club,
        this.especialidad,
        this.usuario,
    });

    Socio copyWith({
        int id,
        String numeroCedula,
        String nombreCompleto,
        String correoElectronico,
        String celular,
        DateTime fechaNacimiento,
        int informacionComercial,
        int club,
        int especialidad,
        int usuario,
    }) => 
        Socio(
            id: id ?? this.id,
            numeroCedula: numeroCedula ?? this.numeroCedula,
            nombreCompleto: nombreCompleto ?? this.nombreCompleto,
            correoElectronico: correoElectronico ?? this.correoElectronico,
            celular: celular ?? this.celular,
            fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
            informacionComercial: informacionComercial ?? this.informacionComercial,
            club: club ?? this.club,
            especialidad: especialidad ?? this.especialidad,
            usuario: usuario ?? this.usuario,
        );

    factory Socio.fromJson(Map<String, dynamic> json) => Socio(
        id: json["id"] == null ? null : json["id"],
        numeroCedula: json["numeroCedula"] == null ? null : json["numeroCedula"],
        nombreCompleto: json["nombreCompleto"] == null ? null : json["nombreCompleto"],
        correoElectronico: json["correoElectronico"] == null ? null : json["correoElectronico"],
        celular: json["celular"] == null ? null : json["celular"],
        fechaNacimiento: json["fechaNacimiento"] == null ? null : DateTime.parse(json["fechaNacimiento"]),
        informacionComercial: json["informacionComercial"] == null ? null : json["informacionComercial"],
        club: json["club"] == null ? null : json["club"],
        especialidad: json["especialidad"] == null ? null : json["especialidad"],
        usuario: json["usuario"] == null ? null : json["usuario"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "numeroCedula": numeroCedula == null ? null : numeroCedula,
        "nombreCompleto": nombreCompleto == null ? null : nombreCompleto,
        "correoElectronico": correoElectronico == null ? null : correoElectronico,
        "celular": celular == null ? null : celular,
        "fechaNacimiento": fechaNacimiento == null ? null : "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "informacionComercial": informacionComercial == null ? null : informacionComercial,
        "club": club == null ? null : club,
        "especialidad": especialidad == null ? null : especialidad,
        "usuario": usuario == null ? null : usuario,
    };
}

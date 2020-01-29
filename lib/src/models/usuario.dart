// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

List<Usuario> usuarioFromJson(String str) => List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
    int idUsuario;
    String nombreUsuario;
    String contrasenia;
    String tipo;
    int estado;

    Usuario({
        this.idUsuario,
        this.nombreUsuario,
        this.contrasenia,
        this.tipo,
        this.estado,
    });

    Usuario copyWith({
        int idUsuario,
        String nombreUsuario,
        String contrasenia,
        String tipo,
        int estado,
    }) => 
        Usuario(
            idUsuario: idUsuario ?? this.idUsuario,
            nombreUsuario: nombreUsuario ?? this.nombreUsuario,
            contrasenia: contrasenia ?? this.contrasenia,
            tipo: tipo ?? this.tipo,
            estado: estado ?? this.estado,
        );

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["idUsuario"] == null ? null : json["idUsuario"],
        nombreUsuario: json["nombreUsuario"] == null ? null : json["nombreUsuario"],
        contrasenia: json["contrasenia"] == null ? null : json["contrasenia"],
        tipo: json["tipo"] == null ? null : json["tipo"],
        estado: json["estado"] == null ? null : json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario == null ? null : idUsuario,
        "nombreUsuario": nombreUsuario == null ? null : nombreUsuario,
        "contrasenia": contrasenia == null ? null : contrasenia,
        "tipo": tipo == null ? null : tipo,
        "estado": estado == null ? null : estado,
    };
}

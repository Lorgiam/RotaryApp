// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

List<Usuario> usuarioFromJson(String str) => List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
    int idUsuario;
    String contrasenia;
    String tipo;
    int estado;
    String nombreUsuario;

    Usuario({
        this.idUsuario,
        this.contrasenia,
        this.tipo,
        this.estado,
        this.nombreUsuario,
    });

    Usuario copyWith({
        int idUsuario,
        String contrasenia,
        String tipo,
        int estado,
        String nombreUsuario,
    }) => 
        Usuario(
            idUsuario: idUsuario ?? this.idUsuario,
            contrasenia: contrasenia ?? this.contrasenia,
            tipo: tipo ?? this.tipo,
            estado: estado ?? this.estado,
            nombreUsuario: nombreUsuario ?? this.nombreUsuario,
        );

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["id_usuario"] == null ? null : json["id_usuario"],
        contrasenia: json["contrasenia"] == null ? null : json["contrasenia"],
        tipo: json["tipo"] == null ? null : json["tipo"],
        estado: json["estado"] == null ? null : json["estado"],
        nombreUsuario: json["nombreUsuario"] == null ? null : json["nombreUsuario"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario == null ? null : idUsuario,
        "contrasenia": contrasenia == null ? null : contrasenia,
        "tipo": tipo == null ? null : tipo,
        "estado": estado == null ? null : estado,
        "nombreUsuario": nombreUsuario == null ? null : nombreUsuario,
    };
}

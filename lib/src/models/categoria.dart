// To parse this JSON data, do
//
//     final categoria = categoriaFromJson(jsonString);

import 'dart:convert';

List<Categoria> categoriaFromJson(String str) => List<Categoria>.from(json.decode(str).map((x) => Categoria.fromJson(x)));

String categoriaToJson(List<Categoria> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categoria {
    int idCategoria;
    String nombreCategoria;

    Categoria({
        this.idCategoria,
        this.nombreCategoria,
    });

    Categoria copyWith({
        int idCategoria,
        String nombreCategoria,
    }) => 
        Categoria(
            idCategoria: idCategoria ?? this.idCategoria,
            nombreCategoria: nombreCategoria ?? this.nombreCategoria,
        );

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        idCategoria: json["idCategoria"] == null ? null : json["idCategoria"],
        nombreCategoria: json["nombreCategoria"] == null ? null : json["nombreCategoria"],
    );

    Map<String, dynamic> toJson() => {
        "idCategoria": idCategoria == null ? null : idCategoria,
        "nombreCategoria": nombreCategoria == null ? null : nombreCategoria,
    };
}

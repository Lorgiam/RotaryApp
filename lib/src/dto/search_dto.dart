// To parse this JSON data, do
//
//     final searchDto = searchDtoFromJson(jsonString);

import 'dart:convert';

SearchDto searchDtoFromJson(String str) => SearchDto.fromJson(json.decode(str));

String searchDtoToJson(SearchDto data) => json.encode(data.toJson());

class SearchDto {
  String categoria;
  String descripcion;
  String ciudad;
  String nombre;
  int estado;
  String perfil;

  SearchDto({
    this.categoria,
    this.descripcion,
    this.ciudad,
    this.nombre,
    this.estado,
    this.perfil,
  });

  SearchDto copyWith({
    String categoria,
    String descripcion,
    String ciudad,
    String nombre,
    int estado,
    String perfil,
  }) =>
      SearchDto(
        categoria: categoria ?? this.categoria,
        descripcion: descripcion ?? this.descripcion,
        ciudad: ciudad ?? this.ciudad,
        nombre: nombre ?? this.nombre,
        estado: estado ?? this.estado,
        perfil: perfil ?? this.perfil,
      );

  factory SearchDto.fromJson(Map<String, dynamic> json) => SearchDto(
        categoria: json["categoria"] == null ? null : json["categoria"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        ciudad: json["ciudad"] == null ? null : json["ciudad"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        estado: json["estado"] == null ? null : json["estado"],
        perfil: json["perfil"] == null ? null : json["perfil"],
      );

  Map<String, dynamic> toJson() => {
        "categoria": categoria == null ? null : categoria,
        "descripcion": descripcion == null ? null : descripcion,
        "ciudad": ciudad == null ? null : ciudad,
        "nombre": nombre == null ? null : nombre,
        "estado": estado == null ? null : estado,
        "perfil": perfil == null ? null : perfil,
      };
}

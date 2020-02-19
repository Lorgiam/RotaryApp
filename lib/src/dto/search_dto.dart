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

    SearchDto({
        this.categoria,
        this.descripcion,
        this.ciudad,
    });

    SearchDto copyWith({
        String especialidad,
        String descripcion,
        String ciudad,
    }) => 
        SearchDto(
            categoria: especialidad ?? this.categoria,
            descripcion: descripcion ?? this.descripcion,
            ciudad: ciudad ?? this.ciudad,
        );

    factory SearchDto.fromJson(Map<String, dynamic> json) => SearchDto(
        categoria: json["categoria"] == null ? null : json["categoria"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        ciudad: json["ciudad"] == null ? null : json["ciudad"],
    );

    Map<String, dynamic> toJson() => {
        "categoria": categoria == null ? null : categoria,
        "descripcion": descripcion == null ? null : descripcion,
        "ciudad": ciudad == null ? null : ciudad,
    };
}

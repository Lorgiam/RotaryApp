// To parse this JSON data, do
//
//     final searchDto = searchDtoFromJson(jsonString);

import 'dart:convert';

SearchDto searchDtoFromJson(String str) => SearchDto.fromJson(json.decode(str));

String searchDtoToJson(SearchDto data) => json.encode(data.toJson());

class SearchDto {
    String especialidad;
    String descripcion;
    String ciudad;

    SearchDto({
        this.especialidad,
        this.descripcion,
        this.ciudad,
    });

    SearchDto copyWith({
        String especialidad,
        String descripcion,
        String ciudad,
    }) => 
        SearchDto(
            especialidad: especialidad ?? this.especialidad,
            descripcion: descripcion ?? this.descripcion,
            ciudad: ciudad ?? this.ciudad,
        );

    factory SearchDto.fromJson(Map<String, dynamic> json) => SearchDto(
        especialidad: json["especialidad"] == null ? null : json["especialidad"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        ciudad: json["ciudad"] == null ? null : json["ciudad"],
    );

    Map<String, dynamic> toJson() => {
        "especialidad": especialidad == null ? null : especialidad,
        "descripcion": descripcion == null ? null : descripcion,
        "ciudad": ciudad == null ? null : ciudad,
    };
}

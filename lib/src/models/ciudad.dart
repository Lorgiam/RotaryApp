import 'dart:convert';

List<Ciudad> ciudadFromJson(String str) =>
    List<Ciudad>.from(json.decode(str).map((x) => Ciudad.fromJson(x)));

String ciudadToJson(List<Ciudad> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ciudad {
  int id;
  String nombreCiudad;
  int idDepartamento;

  Ciudad({
    this.id,
    this.nombreCiudad,
    this.idDepartamento,
  });

  Ciudad copyWith({
    int id,
    String nombreCiudad,
    int idDepartamento,
  }) =>
      Ciudad(
        id: id ?? this.id,
        nombreCiudad: nombreCiudad ?? this.nombreCiudad,
        idDepartamento: idDepartamento ?? this.idDepartamento,
      );

  factory Ciudad.fromJson(Map<String, dynamic> json) => Ciudad(
        id: json["id"] == null ? null : json["id"],
        nombreCiudad:
            json["nombreCiudad"] == null ? null : json["nombreCiudad"],
        idDepartamento:
            json["idDepartamento"] == null ? null : json["idDepartamento"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombreCiudad": nombreCiudad == null ? null : nombreCiudad,
        "idDepartamento": idDepartamento == null ? null : idDepartamento,
      };
}

// To parse this JSON data, do
//
//     final informacionComercial = informacionComercialFromJson(jsonString);

import 'dart:convert';

List<InformacionComercial> informacionComercialFromJson(String str) =>
    List<InformacionComercial>.from(
        json.decode(str).map((x) => InformacionComercial.fromJson(x)));

String informacionComercialToJson(List<InformacionComercial> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InformacionComercial {
  int id;
  String nombreComercial;
  String direccionComercial;
  String descripcionServicio;
  String telefono;
  String paginaEmail;
  int ofrecer;
  int ciudad;

  InformacionComercial({
    this.id,
    this.nombreComercial,
    this.direccionComercial,
    this.descripcionServicio,
    this.telefono,
    this.paginaEmail,
    this.ofrecer,
    this.ciudad,
  });

  InformacionComercial copyWith({
    int id,
    String nombreComercial,
    String direccionComercial,
    String descripcionServicio,
    String telefono,
    String paginaEmail,
    int ofrecer,
    int ciudad,
  }) =>
      InformacionComercial(
        id: id ?? this.id,
        nombreComercial: nombreComercial ?? this.nombreComercial,
        direccionComercial: direccionComercial ?? this.direccionComercial,
        descripcionServicio: descripcionServicio ?? this.descripcionServicio,
        telefono: telefono ?? this.telefono,
        paginaEmail: paginaEmail ?? this.paginaEmail,
        ofrecer: ofrecer ?? this.ofrecer,
        ciudad: ciudad ?? this.ciudad,
      );

  factory InformacionComercial.fromJson(Map<String, dynamic> json) =>
      InformacionComercial(
        id: json["id"] == null ? null : json["id"],
        nombreComercial:
            json["nombreComercial"] == null ? null : json["nombreComercial"],
        direccionComercial: json["direccionComercial"] == null
            ? null
            : json["direccionComercial"],
        descripcionServicio: json["descripcionServicio"] == null
            ? null
            : json["descripcionServicio"],
        telefono: json["telefono"] == null ? null : json["telefono"],
        paginaEmail: json["paginaEmail"] == null ? null : json["paginaEmail"],
        ofrecer: json["ofrecer"] == null ? null : json["ofrecer"],
        ciudad: json["ciudad"] == null ? null : json["ciudad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombreComercial": nombreComercial == null ? null : nombreComercial,
        "direccionComercial":
            direccionComercial == null ? null : direccionComercial,
        "descripcionServicio":
            descripcionServicio == null ? null : descripcionServicio,
        "telefono": telefono == null ? null : telefono,
        "paginaEmail": paginaEmail == null ? null : paginaEmail,
        "ofrecer": ofrecer == null ? null : ofrecer,
        "ciudad": ciudad == null ? null : ciudad,
      };
}

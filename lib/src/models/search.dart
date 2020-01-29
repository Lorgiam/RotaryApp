// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

List<Search> searchFromJson(String str) => List<Search>.from(json.decode(str).map((x) => Search.fromJson(x)));

String searchToJson(List<Search> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Search {
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
    InformacionComercialEntity informacionComercialEntity;
    CiudadEntity ciudadEntity;
    ClubEntity clubEntity;
    EspecialidadEntity especialidadEntity;
    UsuarioEntity usuarioEntity;

    Search({
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
        this.informacionComercialEntity,
        this.ciudadEntity,
        this.clubEntity,
        this.especialidadEntity,
        this.usuarioEntity,
    });

    Search copyWith({
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
        InformacionComercialEntity informacionComercialEntity,
        CiudadEntity ciudadEntity,
        ClubEntity clubEntity,
        EspecialidadEntity especialidadEntity,
        UsuarioEntity usuarioEntity,
    }) => 
        Search(
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
            informacionComercialEntity: informacionComercialEntity ?? this.informacionComercialEntity,
            ciudadEntity: ciudadEntity ?? this.ciudadEntity,
            clubEntity: clubEntity ?? this.clubEntity,
            especialidadEntity: especialidadEntity ?? this.especialidadEntity,
            usuarioEntity: usuarioEntity ?? this.usuarioEntity,
        );

    factory Search.fromJson(Map<String, dynamic> json) => Search(
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
        informacionComercialEntity: json["informacionComercialEntity"] == null ? null : InformacionComercialEntity.fromJson(json["informacionComercialEntity"]),
        ciudadEntity: json["ciudadEntity"] == null ? null : CiudadEntity.fromJson(json["ciudadEntity"]),
        clubEntity: json["clubEntity"] == null ? null : ClubEntity.fromJson(json["clubEntity"]),
        especialidadEntity: json["especialidadEntity"] == null ? null : EspecialidadEntity.fromJson(json["especialidadEntity"]),
        usuarioEntity: json["usuarioEntity"] == null ? null : UsuarioEntity.fromJson(json["usuarioEntity"]),
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
        "informacionComercialEntity": informacionComercialEntity == null ? null : informacionComercialEntity.toJson(),
        "ciudadEntity": ciudadEntity == null ? null : ciudadEntity.toJson(),
        "clubEntity": clubEntity == null ? null : clubEntity.toJson(),
        "especialidadEntity": especialidadEntity == null ? null : especialidadEntity.toJson(),
        "usuarioEntity": usuarioEntity == null ? null : usuarioEntity.toJson(),
    };
}

class CiudadEntity {
    int idCiudad;
    String nombreCiudad;
    int idDepartamento;

    CiudadEntity({
        this.idCiudad,
        this.nombreCiudad,
        this.idDepartamento,
    });

    CiudadEntity copyWith({
        int idCiudad,
        String nombreCiudad,
        int idDepartamento,
    }) => 
        CiudadEntity(
            idCiudad: idCiudad ?? this.idCiudad,
            nombreCiudad: nombreCiudad ?? this.nombreCiudad,
            idDepartamento: idDepartamento ?? this.idDepartamento,
        );

    factory CiudadEntity.fromJson(Map<String, dynamic> json) => CiudadEntity(
        idCiudad: json["idCiudad"] == null ? null : json["idCiudad"],
        nombreCiudad: json["nombreCiudad"] == null ? null : json["nombreCiudad"],
        idDepartamento: json["idDepartamento"] == null ? null : json["idDepartamento"],
    );

    Map<String, dynamic> toJson() => {
        "idCiudad": idCiudad == null ? null : idCiudad,
        "nombreCiudad": nombreCiudad == null ? null : nombreCiudad,
        "idDepartamento": idDepartamento == null ? null : idDepartamento,
    };
}

class ClubEntity {
    int idClub;
    String nombreClub;

    ClubEntity({
        this.idClub,
        this.nombreClub,
    });

    ClubEntity copyWith({
        int idClub,
        String nombreClub,
    }) => 
        ClubEntity(
            idClub: idClub ?? this.idClub,
            nombreClub: nombreClub ?? this.nombreClub,
        );

    factory ClubEntity.fromJson(Map<String, dynamic> json) => ClubEntity(
        idClub: json["idClub"] == null ? null : json["idClub"],
        nombreClub: json["nombreClub"] == null ? null : json["nombreClub"],
    );

    Map<String, dynamic> toJson() => {
        "idClub": idClub == null ? null : idClub,
        "nombreClub": nombreClub == null ? null : nombreClub,
    };
}

class EspecialidadEntity {
    int idEspecialidad;
    String nombreEspecialidad;
    int profesion;

    EspecialidadEntity({
        this.idEspecialidad,
        this.nombreEspecialidad,
        this.profesion,
    });

    EspecialidadEntity copyWith({
        int idEspecialidad,
        String nombreEspecialidad,
        int profesion,
    }) => 
        EspecialidadEntity(
            idEspecialidad: idEspecialidad ?? this.idEspecialidad,
            nombreEspecialidad: nombreEspecialidad ?? this.nombreEspecialidad,
            profesion: profesion ?? this.profesion,
        );

    factory EspecialidadEntity.fromJson(Map<String, dynamic> json) => EspecialidadEntity(
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

class InformacionComercialEntity {
    int idInformacion;
    String nombreComercial;
    String direccionComercial;
    String descripcionServicio;
    String telefono;
    String paginaEmail;
    dynamic ofrecer;
    int ciudad;

    InformacionComercialEntity({
        this.idInformacion,
        this.nombreComercial,
        this.direccionComercial,
        this.descripcionServicio,
        this.telefono,
        this.paginaEmail,
        this.ofrecer,
        this.ciudad,
    });

    InformacionComercialEntity copyWith({
        int idInformacion,
        String nombreComercial,
        String direccionComercial,
        String descripcionServicio,
        String telefono,
        String paginaEmail,
        dynamic ofrecer,
        int ciudad,
    }) => 
        InformacionComercialEntity(
            idInformacion: idInformacion ?? this.idInformacion,
            nombreComercial: nombreComercial ?? this.nombreComercial,
            direccionComercial: direccionComercial ?? this.direccionComercial,
            descripcionServicio: descripcionServicio ?? this.descripcionServicio,
            telefono: telefono ?? this.telefono,
            paginaEmail: paginaEmail ?? this.paginaEmail,
            ofrecer: ofrecer ?? this.ofrecer,
            ciudad: ciudad ?? this.ciudad,
        );

    factory InformacionComercialEntity.fromJson(Map<String, dynamic> json) => InformacionComercialEntity(
        idInformacion: json["idInformacion"] == null ? null : json["idInformacion"],
        nombreComercial: json["nombreComercial"] == null ? null : json["nombreComercial"],
        direccionComercial: json["direccionComercial"] == null ? null : json["direccionComercial"],
        descripcionServicio: json["descripcionServicio"] == null ? null : json["descripcionServicio"],
        telefono: json["telefono"] == null ? null : json["telefono"],
        paginaEmail: json["paginaEmail"] == null ? null : json["paginaEmail"],
        ofrecer: json["ofrecer"],
        ciudad: json["ciudad"] == null ? null : json["ciudad"],
    );

    Map<String, dynamic> toJson() => {
        "idInformacion": idInformacion == null ? null : idInformacion,
        "nombreComercial": nombreComercial == null ? null : nombreComercial,
        "direccionComercial": direccionComercial == null ? null : direccionComercial,
        "descripcionServicio": descripcionServicio == null ? null : descripcionServicio,
        "telefono": telefono == null ? null : telefono,
        "paginaEmail": paginaEmail == null ? null : paginaEmail,
        "ofrecer": ofrecer,
        "ciudad": ciudad == null ? null : ciudad,
    };
}

class UsuarioEntity {
    int idUsuario;
    String nombreUsuario;
    dynamic contrasenia;
    String tipo;
    int estado;

    UsuarioEntity({
        this.idUsuario,
        this.nombreUsuario,
        this.contrasenia,
        this.tipo,
        this.estado,
    });

    UsuarioEntity copyWith({
        int idUsuario,
        String nombreUsuario,
        dynamic contrasenia,
        String tipo,
        int estado,
    }) => 
        UsuarioEntity(
            idUsuario: idUsuario ?? this.idUsuario,
            nombreUsuario: nombreUsuario ?? this.nombreUsuario,
            contrasenia: contrasenia ?? this.contrasenia,
            tipo: tipo ?? this.tipo,
            estado: estado ?? this.estado,
        );

    factory UsuarioEntity.fromJson(Map<String, dynamic> json) => UsuarioEntity(
        idUsuario: json["idUsuario"] == null ? null : json["idUsuario"],
        nombreUsuario: json["nombreUsuario"] == null ? null : json["nombreUsuario"],
        contrasenia: json["contrasenia"],
        tipo: json["tipo"] == null ? null : json["tipo"],
        estado: json["estado"] == null ? null : json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario == null ? null : idUsuario,
        "nombreUsuario": nombreUsuario == null ? null : nombreUsuario,
        "contrasenia": contrasenia,
        "tipo": tipo == null ? null : tipo,
        "estado": estado == null ? null : estado,
    };
}

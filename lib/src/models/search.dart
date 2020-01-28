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
    int id;
    String nombreCiudad;
    int idDepartamento;

    CiudadEntity({
        this.id,
        this.nombreCiudad,
        this.idDepartamento,
    });

    CiudadEntity copyWith({
        int id,
        String nombreCiudad,
        int idDepartamento,
    }) => 
        CiudadEntity(
            id: id ?? this.id,
            nombreCiudad: nombreCiudad ?? this.nombreCiudad,
            idDepartamento: idDepartamento ?? this.idDepartamento,
        );

    factory CiudadEntity.fromJson(Map<String, dynamic> json) => CiudadEntity(
        id: json["id"] == null ? null : json["id"],
        nombreCiudad: json["nombreCiudad"] == null ? null : json["nombreCiudad"],
        idDepartamento: json["idDepartamento"] == null ? null : json["idDepartamento"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombreCiudad": nombreCiudad == null ? null : nombreCiudad,
        "idDepartamento": idDepartamento == null ? null : idDepartamento,
    };
}

class ClubEntity {
    int id;
    String nombreClub;

    ClubEntity({
        this.id,
        this.nombreClub,
    });

    ClubEntity copyWith({
        int id,
        String nombreClub,
    }) => 
        ClubEntity(
            id: id ?? this.id,
            nombreClub: nombreClub ?? this.nombreClub,
        );

    factory ClubEntity.fromJson(Map<String, dynamic> json) => ClubEntity(
        id: json["id"] == null ? null : json["id"],
        nombreClub: json["nombreClub"] == null ? null : json["nombreClub"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombreClub": nombreClub == null ? null : nombreClub,
    };
}

class EspecialidadEntity {
    int id;
    String nombreEspecialidad;
    int idProfesion;

    EspecialidadEntity({
        this.id,
        this.nombreEspecialidad,
        this.idProfesion,
    });

    EspecialidadEntity copyWith({
        int id,
        String nombreEspecialidad,
        int idProfesion,
    }) => 
        EspecialidadEntity(
            id: id ?? this.id,
            nombreEspecialidad: nombreEspecialidad ?? this.nombreEspecialidad,
            idProfesion: idProfesion ?? this.idProfesion,
        );

    factory EspecialidadEntity.fromJson(Map<String, dynamic> json) => EspecialidadEntity(
        id: json["id"] == null ? null : json["id"],
        nombreEspecialidad: json["nombreEspecialidad"] == null ? null : json["nombreEspecialidad"],
        idProfesion: json["idProfesion"] == null ? null : json["idProfesion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombreEspecialidad": nombreEspecialidad == null ? null : nombreEspecialidad,
        "idProfesion": idProfesion == null ? null : idProfesion,
    };
}

class InformacionComercialEntity {
    int id;
    String nombreComercial;
    String direccionComercial;
    String descripcionServicio;
    String telefono;
    String paginaEmail;
    int ofrecer;
    int ciudad;

    InformacionComercialEntity({
        this.id,
        this.nombreComercial,
        this.direccionComercial,
        this.descripcionServicio,
        this.telefono,
        this.paginaEmail,
        this.ofrecer,
        this.ciudad,
    });

    InformacionComercialEntity copyWith({
        int id,
        String nombreComercial,
        String direccionComercial,
        String descripcionServicio,
        String telefono,
        String paginaEmail,
        int ofrecer,
        int ciudad,
    }) => 
        InformacionComercialEntity(
            id: id ?? this.id,
            nombreComercial: nombreComercial ?? this.nombreComercial,
            direccionComercial: direccionComercial ?? this.direccionComercial,
            descripcionServicio: descripcionServicio ?? this.descripcionServicio,
            telefono: telefono ?? this.telefono,
            paginaEmail: paginaEmail ?? this.paginaEmail,
            ofrecer: ofrecer ?? this.ofrecer,
            ciudad: ciudad ?? this.ciudad,
        );

    factory InformacionComercialEntity.fromJson(Map<String, dynamic> json) => InformacionComercialEntity(
        id: json["id"] == null ? null : json["id"],
        nombreComercial: json["nombreComercial"] == null ? null : json["nombreComercial"],
        direccionComercial: json["direccionComercial"] == null ? null : json["direccionComercial"],
        descripcionServicio: json["descripcionServicio"] == null ? null : json["descripcionServicio"],
        telefono: json["telefono"] == null ? null : json["telefono"],
        paginaEmail: json["paginaEmail"] == null ? null : json["paginaEmail"],
        ofrecer: json["ofrecer"] == null ? null : json["ofrecer"],
        ciudad: json["ciudad"] == null ? null : json["ciudad"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombreComercial": nombreComercial == null ? null : nombreComercial,
        "direccionComercial": direccionComercial == null ? null : direccionComercial,
        "descripcionServicio": descripcionServicio == null ? null : descripcionServicio,
        "telefono": telefono == null ? null : telefono,
        "paginaEmail": paginaEmail == null ? null : paginaEmail,
        "ofrecer": ofrecer == null ? null : ofrecer,
        "ciudad": ciudad == null ? null : ciudad,
    };
}

class UsuarioEntity {
    int idUsuario;
    dynamic contrasenia;
    String tipo;
    int estado;
    String nombreUsuario;

    UsuarioEntity({
        this.idUsuario,
        this.contrasenia,
        this.tipo,
        this.estado,
        this.nombreUsuario,
    });

    UsuarioEntity copyWith({
        int idUsuario,
        dynamic contrasenia,
        String tipo,
        int estado,
        String nombreUsuario,
    }) => 
        UsuarioEntity(
            idUsuario: idUsuario ?? this.idUsuario,
            contrasenia: contrasenia ?? this.contrasenia,
            tipo: tipo ?? this.tipo,
            estado: estado ?? this.estado,
            nombreUsuario: nombreUsuario ?? this.nombreUsuario,
        );

    factory UsuarioEntity.fromJson(Map<String, dynamic> json) => UsuarioEntity(
        idUsuario: json["id_usuario"] == null ? null : json["id_usuario"],
        contrasenia: json["contrasenia"],
        tipo: json["tipo"] == null ? null : json["tipo"],
        estado: json["estado"] == null ? null : json["estado"],
        nombreUsuario: json["nombreUsuario"] == null ? null : json["nombreUsuario"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario == null ? null : idUsuario,
        "contrasenia": contrasenia,
        "tipo": tipo == null ? null : tipo,
        "estado": estado == null ? null : estado,
        "nombreUsuario": nombreUsuario == null ? null : nombreUsuario,
    };
}

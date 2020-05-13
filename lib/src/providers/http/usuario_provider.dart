import 'package:rotary/src/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rotary/src/utils/constants.dart';

class UsuarioProvider {
  UsuarioProvider();

  Future<Usuario> save(Usuario usu) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .post('https://${Constants.URL_API}/usuario/save',
            headers: mapHeaders, body: json.encode(usu.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        final data = json.decode(jsonData.body);
        if (data.isNotEmpty) {
          final Usuario us = Usuario.fromJson(data);
          return us;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<Usuario> update(Usuario usu, int idUsuario) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .put('https://${Constants.URL_API}/usuario/update/$idUsuario',
            headers: mapHeaders, body: json.encode(usu.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        final data = json.decode(jsonData.body);
        if (data.isNotEmpty) {
          final Usuario us = Usuario.fromJson(data);
          return us;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<Usuario> updateEstado(int id, int estado) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('https://${Constants.URL_API}/usuario/updateEstado/$id/$estado',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        final data = json.decode(jsonData.body);
        if (data.isNotEmpty) {
          final Usuario us = Usuario.fromJson(data);
          return us;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<Usuario> updatePerfil(int id, String perfil) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('https://${Constants.URL_API}/usuario/updatePerfil/$id/$perfil',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        final data = json.decode(jsonData.body);
        if (data.isNotEmpty) {
          final Usuario us = Usuario.fromJson(data);
          return us;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }).catchError((err) {
      print(err);
    });
  }
}

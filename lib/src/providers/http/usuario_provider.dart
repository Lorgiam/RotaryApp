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
        .post('http://${Constants.URL_API}/usuario/save',
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
    print('http://${Constants.URL_API}/usuario/updateEstado/$id/$estado');
    return await http
        .get(
      'http://${Constants.URL_API}/usuario/updateEstado/$id/$estado',
      headers: mapHeaders
    )
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

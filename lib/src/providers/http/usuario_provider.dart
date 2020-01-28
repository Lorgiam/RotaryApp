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
        String l = utf8.decode(jsonData.bodyBytes);
        Iterable le = json.decode(l);
        if (le.isNotEmpty) {
          final Usuario us = Usuario.fromJson(le.first);
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

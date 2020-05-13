import 'package:rotary/src/dto/auth_dto.dart';
import 'package:rotary/src/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:rotary/src/utils/constants.dart';

class AuthProvider {
  AuthProvider();

  Future<Usuario> login(AuthDto auth) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .post('https://${Constants.URL_API}/usuario/login',
            headers: mapHeaders, body: json.encode(auth.toJson()))
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

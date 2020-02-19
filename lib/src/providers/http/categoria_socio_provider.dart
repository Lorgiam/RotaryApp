import 'package:rotary/src/dto/categoria_socio_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:rotary/src/models/categoria_socio.dart';
import 'package:rotary/src/utils/constants.dart';

class CategoriaSocioProvider {
  CategoriaSocioProvider();

  Future<CategoriaSocio> save(CategoriaSocioDto cts) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .post('http://${Constants.URL_API}/categoriaSocio/save',
            headers: mapHeaders, body: json.encode(cts.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        final data = json.decode(jsonData.body);
        if (data.isNotEmpty) {
          final CategoriaSocio sc = CategoriaSocio.fromJson(data);
          return sc;
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

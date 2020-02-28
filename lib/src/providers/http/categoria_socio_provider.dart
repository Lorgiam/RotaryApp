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

  Future<List<CategoriaSocio>> findCategoriasBySocios(int idSocio) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('http://${Constants.URL_API}/categoriaSocio/findBySocio/$idSocio',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        Iterable l = json.decode(jsonData.body);
        if (l.isNotEmpty) {
          return List<CategoriaSocio>.from(
              l.map((x) => CategoriaSocio.fromJson(x)));
        } else {
          return [];
        }
      } else {
        return null;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<CategoriaSocio> delete(int idSocio, int idCategoria) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .delete(
            'http://${Constants.URL_API}/categoriaSocio/delete/$idSocio/$idCategoria',
            headers: mapHeaders)
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

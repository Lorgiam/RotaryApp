import 'package:rotary/src/models/categoria.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:rotary/src/utils/constants.dart';

class CategoriaProvider {
  CategoriaProvider();

  Future<List<Categoria>> getCategorias() async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('https://${Constants.URL_API}/categoria/findAll',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        Iterable l = json.decode(jsonData.body);
        if (l.isNotEmpty) {
          return List<Categoria>.from(l.map((x) => Categoria.fromJson(x)));
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

  Future<List<Categoria>> findCategoriasBySocios() async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('https://${Constants.URL_API}/categoria/findCategoriasBySocios',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        Iterable l = json.decode(jsonData.body);
        if (l.isNotEmpty) {
          Categoria categoria = new Categoria();
          categoria.nombreCategoria = 'Todas las Categorias';
          return List<Categoria>.from(l.map((x) => Categoria.fromJson(x)))
            ..insert(0, categoria);
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
}

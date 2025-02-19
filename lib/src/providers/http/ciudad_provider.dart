import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rotary/src/models/ciudad.dart';
import 'package:rotary/src/utils/constants.dart';

class CiudadProvider {
  CiudadProvider();

  Future<List<Ciudad>> getCiudadBySocio() async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('https://${Constants.URL_API}/ciudad/findCiudadBySocio',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        String l = utf8.decode(jsonData.bodyBytes);
        Iterable le = json.decode(l);
        if (le.isNotEmpty) {
          Ciudad ciudad = new Ciudad();
          ciudad.nombreCiudad = 'Todas las Ciudades';
          return List<Ciudad>.from(le.map((x) => Ciudad.fromJson(x)))
            ..insert(0, ciudad);
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

  Future<List<Ciudad>> getCiudades() async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('https://${Constants.URL_API}/ciudad/findAll', headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        String l = utf8.decode(jsonData.bodyBytes);
        Iterable le = json.decode(l);
        if (le.isNotEmpty) {
          return List<Ciudad>.from(le.map((x) => Ciudad.fromJson(x)));
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

  Future<Ciudad> getCiudadById(int id) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('https://${Constants.URL_API}/ciudad/findBy/$id',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        final data = json.decode(jsonData.body);
        if (data.isNotEmpty) {
          String l = utf8.decode(jsonData.bodyBytes);
          final Ciudad sc = Ciudad.fromJson(json.decode(l));
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

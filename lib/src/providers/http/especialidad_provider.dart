import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rotary/src/models/especialidad.dart';
import 'package:rotary/src/utils/constants.dart';

class EspecialidadProvider {
  EspecialidadProvider();

  Future<List<Especialidad>> getEspecialidadesL() async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('http://${Constants.URL_API}/especialidad/findAll',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        String l = utf8.decode(jsonData.bodyBytes);
        Iterable le = json.decode(l);
        if (le.isNotEmpty) {
          return List<Especialidad>.from(
              le.map((x) => Especialidad.fromJson(x)));
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
  Future<List<Especialidad>> getEspecialidades() async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('http://${Constants.URL_API}/especialidad/findEspecialidadBySocio',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        String l = utf8.decode(jsonData.bodyBytes);
        Iterable le = json.decode(l);
        if (le.isNotEmpty) {
          return List<Especialidad>.from(
              le.map((x) => Especialidad.fromJson(x)));
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

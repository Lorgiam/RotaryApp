import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rotary/src/models/especialidad.dart';
import 'package:rotary/src/utils/constants.dart';

class EspecialidadProvider {
  EspecialidadProvider();

  Future<List<Especialidad>> getEspecialidades() async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('http://${Constants.URL_API}/especialidad/findAll',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        Iterable l = json.decode(jsonData.body);
        if (l.isNotEmpty) {
          return List<Especialidad>.from(
              l.map((x) => Especialidad.fromJson(x)));
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

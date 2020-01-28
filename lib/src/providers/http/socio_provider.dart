import 'package:rotary/src/models/socio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:rotary/src/utils/constants.dart';

class SocioProvider {
  SocioProvider();

  Future<List<Socio>> getSocios() async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('http://${Constants.URL_API}/socio/findAll', headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        Iterable l = json.decode(jsonData.body);
        if (l.isNotEmpty) {
          return List<Socio>.from(l.map((x) => Socio.fromJson(x)));
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

  Future<Socio> save(Socio scs) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .post('http://${Constants.URL_API}/socio/save',
            headers: mapHeaders, body: json.encode(scs.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        String l = utf8.decode(jsonData.bodyBytes);
        Iterable le = json.decode(l);
        if (le.isNotEmpty) {
          final Socio sc = Socio.fromJson(le.first);
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

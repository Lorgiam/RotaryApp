import 'package:rotary/src/models/informacion_comercial.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rotary/src/utils/constants.dart';

class InformacionComercialProvider {
  InformacionComercialProvider();

  Future<InformacionComercial> save(InformacionComercial infoco) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .post('https://${Constants.URL_API}/informacionComercial/save',
            headers: mapHeaders, body: json.encode(infoco.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        final data = json.decode(jsonData.body);
        if (data.isNotEmpty) {
          final InformacionComercial info = InformacionComercial.fromJson(data);
          return info;
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

  Future<InformacionComercial> update(
      InformacionComercial infoco, int idInfoPro) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .put(
            'https://${Constants.URL_API}/informacionComercial/update/$idInfoPro ',
            headers: mapHeaders,
            body: json.encode(infoco.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        final data = json.decode(jsonData.body);
        if (data.isNotEmpty) {
          final InformacionComercial info = InformacionComercial.fromJson(data);
          return info;
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

  Future<InformacionComercial> getInfoCoById(int id) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('https://${Constants.URL_API}/informacionComercial/findBy/$id',
            headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        final data = json.decode(jsonData.body);
        if (data.isNotEmpty) {
          final InformacionComercial sc = InformacionComercial.fromJson(data);
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

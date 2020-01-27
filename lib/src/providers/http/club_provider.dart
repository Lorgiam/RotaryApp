import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rotary/src/models/club.dart';
import 'package:rotary/src/utils/constants.dart';

class ClubProvider {
  ClubProvider();

  Future<List<Club>> getClubes() async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .get('http://${Constants.URL_API}/club/findAll', headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        String l = utf8.decode(jsonData.bodyBytes);
        Iterable le = json.decode(l);
        if (le.isNotEmpty) {
          return List<Club>.from(le.map((x) => Club.fromJson(x)));
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

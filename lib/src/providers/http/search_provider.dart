import 'package:rotary/src/dto/search_dto.dart';
import 'package:rotary/src/models/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rotary/src/utils/constants.dart';

class SearchProvider {
  SearchProvider();

  Future<List<Search>> getSociosSeach(SearchDto searchDto) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    return await http
        .post('http://${Constants.URL_API}/search/findSearch',
            body: json.encode(searchDto.toJson()), headers: mapHeaders)
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        String l = utf8.decode(jsonData.bodyBytes);
        Iterable le = json.decode(l);
        if (le.isNotEmpty) {
          return List<Search>.from(le.map((x) => Search.fromJson(x)));
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

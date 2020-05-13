import 'package:rotary/src/dto/email_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:rotary/src/utils/constants.dart';

class EmailProvider {
  EmailProvider();

  Future<int> save(EmailDto emailDto) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .post('https://${Constants.URL_API}/mail/send',
            headers: mapHeaders, body: json.encode(emailDto.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<int> saveSoc(EmailDto emailDto) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .post('https://${Constants.URL_API}/mail/sendSoc',
            headers: mapHeaders, body: json.encode(emailDto.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        return 1;
      } else {
        print(jsonData.body);
        return 0;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<int> saveAdm(EmailDto emailDto) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .post('https://${Constants.URL_API}/mail/sendAdm',
            headers: mapHeaders, body: json.encode(emailDto.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<int> sendChangePerfil(EmailDto emailDto) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .post('https://${Constants.URL_API}/mail/sendChangePerfil',
            headers: mapHeaders, body: json.encode(emailDto.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<int> sendChangeEst(EmailDto emailDto) async {
    final Map<String, String> mapHeaders = {
      'Content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };
    return await http
        .post('https://${Constants.URL_API}/mail/sendChangeEst',
            headers: mapHeaders, body: json.encode(emailDto.toJson()))
        .then((jsonData) {
      if (jsonData.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }).catchError((err) {
      print(err);
    });
  }
}

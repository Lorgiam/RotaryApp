import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:async';

import 'dart:io';

import 'package:mime_type/mime_type.dart';
import 'package:rotary/src/utils/constants.dart';

class UploadProvider {
  UploadProvider();

  Future<int> save(File image, int id) async {
    final mimeType = mime(image.path).split('/');
    final url = Uri.parse('http://${Constants.URL_API}/file/upload/$id');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final res = await http.Response.fromStream(streamResponse);
    if (res.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}

// ignore_for_file: avoid_print, depend_on_referenced_packages, prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('Ahmed:ah123456'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  getRequast(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print('error ${response.statusCode}');
      }
    } catch (e) {
      print('error catch $e');
    }
  }

  postRequast(String url, Map data, [File? file]) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print('error ${response.statusCode}');
      }
    } catch (e) {
      print('error catch $e');
    }
  }

  postRequastWithFile(String url, Map data, File file) async {
    var requast = http.MultipartRequest("POST", Uri.parse(url));
    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile(
      "file",
      stream,
      lenght,
      filename: basename(file.path),
    );
    requast.headers.addAll(myheaders);
    requast.files.add(multiPartFile);
    data.forEach((key, value) {
      requast.fields[key] = value;
    });
    var myRequest = await requast.send();
    var responce = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      return jsonDecode(responce.body);
    } else {
      print("Error ${myRequest.statusCode}");
    }
  }
}

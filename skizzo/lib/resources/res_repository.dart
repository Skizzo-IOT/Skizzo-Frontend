import 'dart:convert';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skizzo/constants.dart';

class ResRepository {
  Future<List<String>> getAll() async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      final token = pref.getString(kTokenPref);
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http.get(
        Uri.parse('http://$kServer/api/res/getAll'),
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        List<String> data = [];
        for (var test in jsonResponse["files"]) {
          data.add(test);
        }

        return data;
      } else {
        throw const NetworkException("Une erreur est survenue");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<String> uploadImage(Uint8List file, String filename) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      final token = pref.getString(kTokenPref);
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer $token",
      };

      final uri = Uri.http(kServer, '/api/res/upload');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(
        http.MultipartFile.fromBytes(
          "image",
          file,
          filename: filename,
          contentType: MediaType.parse(lookupMimeType(filename)!),
        ),
      );

      request.headers.addAll(requestHeaders);

      var streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        return await streamedResponse.stream.bytesToString();
      } else if (streamedResponse.statusCode == 400) {
        throw const FileToBigException(
            "Le fichier envoy?? est trop volumineux.");
      } else {
        throw NetworkException(
            "Une erreur est survenue, status code: ${streamedResponse.statusCode}");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class FileToBigException implements Exception {
  final String message;
  const FileToBigException(this.message);
}

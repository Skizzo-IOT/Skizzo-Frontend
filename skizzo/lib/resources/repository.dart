import 'dart:convert';

import 'package:skizzo/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<bool> checkToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString(kTokenPref);
    return token != null && token.isNotEmpty;
  }

  Future<void> signin(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final response = await http.post(
      Uri.parse('http://$kServer/api/login/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'email': username,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      SharedPreferences.getInstance()
          .then((value) => value.setString('token', jsonResponse['token']));
    } else {
      if (response.statusCode == 401) {
        throw const UnknowUserException("Identifiants incorrects");
      }

      throw const NetworkException("Une erreur est survenue");
    }
  }
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class UnknowUserException implements Exception {
  final String message;
  const UnknowUserException(this.message);
}

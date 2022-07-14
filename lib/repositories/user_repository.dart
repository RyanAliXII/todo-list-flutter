import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_app/models/user.dart';
import 'package:practice_app/repositories/repository.dart';

class UserRepository extends Repository {
  Future<http.Response> register(User user) async {
    Map bodyObject = {
      'email': user.email,
      'password': user.password,
      'name': user.name
    };
    var jsonBody = json.encode(bodyObject);
    final request = await http.post(
        Uri.parse(
          '$baseURL/users/register',
        ),
        body: jsonBody,
        headers: {});
    return request;
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:practice_app/models/model.dart';
import 'package:http/http.dart' as http;

class User extends Model {
  String? id;
  String? email;
  String? password;
  String? name;

  User({this.id, this.email, this.password, this.name}) : super();

  Future<Response> verifyToken() async {
    await initAuthRequirements();
    final request = await http.post(
        Uri.parse(
          '$baseURL/auth/verify',
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.cookieHeader: cookies,
        });
    return request;
  }

  Future<Response> login() async {
    Map bodyObject = {'email': email, 'password': password};
    var jsonBody = jsonEncode(bodyObject);
    final request = await http.post(
        Uri.parse(
          '$baseURL/users/login',
        ),
        body: jsonBody,
        headers: {});
    return request;
  }
}

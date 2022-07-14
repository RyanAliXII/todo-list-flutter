import 'dart:convert';
import 'dart:io';
import 'package:practice_app/models/task.dart';
import 'package:practice_app/repositories/repository.dart';
import 'package:http/http.dart' as http;

class TaskRepository extends Repository {
  Future<List<Task>> fetch() async {
    final request = await http
        .get(Uri.parse('$baseURL/users/${Repository.session.userId}/tasks'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${Repository.session.token}',
      HttpHeaders.cookieHeader: Repository.session.cookies,
    });
    List<Task> tasks = List.empty();
    if (request.statusCode == 200) {
      var response = json.decode(request.body);
      var listOfTasks = response['data'] as List;
      tasks = listOfTasks.map((t) => Task.fromJson(t)).toList();
    }

    return tasks;
  }

  Future<http.Response> createTodo(Task task) async {
    Map bodyObject = {
      'title': task.title,
      'description': task.description,
    };
    var jsonBody = json.encode(bodyObject);
    final request = await http.post(
        Uri.parse('$baseURL/users/${Repository.session.userId}/tasks'),
        body: jsonBody,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Repository.session.token}',
          HttpHeaders.cookieHeader: Repository.session.cookies
        });
    return request;
  }

  Future<http.Response> deleteTaskByUserIdAndTaskId(int id) async {
    final request = await http.delete(
        Uri.parse(
          '$baseURL/users/${Repository.session.userId}/tasks/$id',
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Repository.session.token}',
          HttpHeaders.cookieHeader: Repository.session.cookies,
        });
    return request;
  }

  Future<http.Response> updateTask(Task task) async {
    Map body = {'title': task.title, 'description': task.description};
    var jsonBody = json.encode(body);
    final request = await http.put(
        Uri.parse('$baseURL/users/${Repository.session.userId}/tasks/${task.id}/'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Repository.session.token}',
          HttpHeaders.cookieHeader: Repository.session.cookies,
        },
        body: jsonBody);
    return request;
  }

  Future<http.Response> updateTaskStatus(int value, int taskId) async {
  
    final request = await http.put(
        Uri.parse('$baseURL/users/${Repository.session.userId}/tasks/$taskId/status/$value'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Repository.session.token}',
          HttpHeaders.cookieHeader: Repository.session.cookies,
        });
    return request;
  }
  

  // Future<TaskRepository>init()async{
  //   TaskRepository repo = TaskRepository();
  //   await repo.initAuthRequirements();
  //   return repo;
  // }

  
}

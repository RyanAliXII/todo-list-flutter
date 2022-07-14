import 'package:flutter/cupertino.dart';
import 'package:practice_app/models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = List.empty();

  setTasks(List<Task> t) {
    tasks = t;
    notifyListeners();
  }

  deleteTaskById(int id) {
    tasks = tasks.where((e) => e.id != id).toList();
    notifyListeners();
  }

  replaceExistingTaskById(Task task) {
    tasks = tasks.map((e) {
      if (e.id == task.id) return task;
      return e;
    }).toList();
    notifyListeners();
  }
}

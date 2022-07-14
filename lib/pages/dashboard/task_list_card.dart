import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:practice_app/common/callbacks.dart';
import 'package:practice_app/components/add_edit_modal.dart';
import 'package:practice_app/components/snackbars.dart';
import 'package:practice_app/models/task.dart';
import 'package:practice_app/pages/task/task_edit.dart';
import 'package:practice_app/providers/repositories_provider.dart';
import 'package:practice_app/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskListCard extends StatefulWidget {
  final Task task;
  const TaskListCard({
    Key? key,
    required this.task,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  @override
  TaskListCard get widget => super.widget;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 5),
        child: InkWell(
          focusColor: const Color.fromARGB(200, 229, 229, 229),
          onTap: _onTapItem,
          child: Row(children: [
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 5, left: 5),
                        alignment: Alignment.topLeft,
                        child: ListTile(
                          title: Text(widget.task.title),
                          subtitle: Text(widget.task.description),
                        ))
                  ],
                )),
            Expanded(
                flex: 1,
                child: Checkbox(
                    value: widget.task.isCompleted == 1,
                    onChanged: _onTaskChecked))
          ]),
        ));
  }

  _onTapItem() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return AddEditBottomModal(onDelete: _deleteItem, onEdit: _editItem);
        });
  }

  _deleteItem() async {
    runIfMounted(mounted, () async {
      Response r = await context
          .read<RepositoryProvider>()
          .taskRepository
          .deleteTaskByUserIdAndTaskId(widget.task.id!);
      if (r.statusCode != StatusCode.OK) return;
      runIfMounted(mounted, () {
        ScaffoldMessenger.of(context)
            .showSnackBar(successSnackbar("Task has been deleted"));
        Navigator.pop(context);
        context.read<TaskProvider>().deleteTaskById(widget.task.id!);
      });
    });
  }

  _editItem() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditTaskPage(
                  task: widget.task,
                ))).whenComplete(_refetch);
  }

  _onTaskChecked(dynamic value) async {
    int bool;
    if (value == false) {
      bool = 0;
    } else {
      bool = 1;
    }

    runIfMounted(mounted, () {
      widget.task.isCompleted = bool;
      context
          .read<RepositoryProvider>()
          .taskRepository
          .updateTaskStatus(bool, widget.task.id!);
      context.read<TaskProvider>().replaceExistingTaskById(widget.task);
    });
  }

  _refetch() async {
    List<Task> tasks =
        await context.read<RepositoryProvider>().taskRepository.fetch();
    runIfMounted(mounted, () {
      context.read<TaskProvider>().setTasks(tasks);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:practice_app/common/callbacks.dart';
import 'package:practice_app/models/task.dart';
import 'package:practice_app/pages/dashboard/task_list_card.dart';
import 'package:practice_app/pages/task/task_create.dart';
import 'package:practice_app/providers/repositories_provider.dart';
import 'package:practice_app/providers/task_provider.dart';
import 'package:practice_app/themes/style.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  @override
  void initState() {
    _fetchTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 20.0, top: 40.0),
                child: const Text(
                  "Tasks",
                  style: TitleText(),
                )),
            Visibility(
                visible: context.watch<TaskProvider>().tasks.isEmpty,
                child: SizedBox(
                    width: 100,
                    height: 500,
                    child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Looks like you dont have a task',
                          style: TextStyle(
                              color: Colors.black54, fontFamily: "Monstserrat"),
                        )))),
            ListView(
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: context
                    .watch<TaskProvider>()
                    .tasks
                    .map((e) => TaskListCard(task: e))
                    .toList())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _redirectToTaskPage,
        label: const Text("New Task"),
        icon: const Icon(Icons.add),
      ),
    ));
  }

  _redirectToTaskPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateTaskPage()),
    ).whenComplete(() => _fetchTasks());
  }

  _fetchTasks() async {
    runIfMounted(mounted, () async {
      List<Task> tasksTemp =
          await context.read<RepositoryProvider>().taskRepository.fetch();
      runIfMounted(mounted, () {
        context.read<TaskProvider>().setTasks(tasksTemp);
      });
    });
  }
}

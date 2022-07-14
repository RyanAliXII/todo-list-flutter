import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:practice_app/common/callbacks.dart';
import 'package:practice_app/common/logging_utils.dart';
import 'package:practice_app/components/snackbars.dart';
import 'package:practice_app/components/spacing.dart';
import 'package:practice_app/models/task.dart';
import 'package:practice_app/providers/repositories_provider.dart';
import 'package:practice_app/themes/style.dart';
import 'package:provider/provider.dart';

Logger logger = Logger("pages:task.dart");

MultiValidator titleValditor = MultiValidator([
  MaxLengthValidator(20, errorText: "Title must not exceed 20 characters"),
  MinLengthValidator(3, errorText: "Title must be atleast 3 characters")
]);

MultiValidator descValditor = MultiValidator([
  MaxLengthValidator(99,
      errorText: "Description must not exceed 99 characters"),
  MinLengthValidator(3, errorText: "Description must be atleast 3 characters")
]);

class EditTaskPage extends StatefulWidget {
  
  late final TextEditingController titleTextFieldController;
  late final  TextEditingController descriptionTextFieldController;
  final Task? task;

  EditTaskPage({Key? key, this.task}) : super(key: key) {
    String title = task?.title ?? "";
    String desc = task?.description ?? "";
    titleTextFieldController = TextEditingController(text: title);
    descriptionTextFieldController = TextEditingController(text: desc);
  }

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            vSpacing20,
            const Text("Edit Task", style: TitleText()),
            vSpacing20,
            TextFormField(
              decoration: const PrimaryTextFieldDecoration(labelText: "Title"),
              controller: widget.titleTextFieldController,
              validator: titleValditor,
            ),
            vSpacing12,
            TextFormField(
              maxLines: 3,
              decoration:
                  const PrimaryTextFieldDecoration(labelText: "Description"),
              controller: widget.descriptionTextFieldController,
              validator: descValditor,
            ),
            vSpacing12,
            Center(
                child: SizedBox(
              width: 200,
              height: 50,
              child: TextButton(
                onPressed: _onSubmit,
                style: PrimaryButtonStyle().init(),
                child: const Text(
                  "Update",
                  style: PrimaryButtonTextStyle(),
                ),
              ),
            ))
          ])),
    ))));
  }

  _onSubmit() async{
  if(formKey.currentState != null){
  if(formKey.currentState!.validate()){
  Task t = Task(
      id:widget.task?.id,
      title: widget.titleTextFieldController.text,
      description: widget.descriptionTextFieldController.text);
      runIfMounted(mounted, ()async{
          Response r = await context.read<RepositoryProvider>().taskRepository.updateTask(t);
          runIfMounted(mounted, (){
             if(r.statusCode == StatusCode.OK){
                  ScaffoldMessenger.of(context).showSnackBar(successSnackbar("Task updated successfully"));
             }
             if(r.statusCode == StatusCode.UNAUTHORIZED){
                    
             }
          });
      });
  }
}  
  }
}



import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:practice_app/common/callbacks.dart';
import 'package:practice_app/common/logging_utils.dart';
import 'package:practice_app/components/snackbars.dart';
import 'package:practice_app/components/spacing.dart';
import 'package:practice_app/providers/repositories_provider.dart';
import 'package:practice_app/themes/style.dart';
import 'package:practice_app/models/task.dart';
import 'package:provider/provider.dart';

Logger logger = Logger("pages:task_create.dart");

MultiValidator titleValditor = MultiValidator([
  MaxLengthValidator(20, errorText: "Title must not exceed 20 characters"),
  MinLengthValidator(3, errorText: "Title must be atleast 3 characters"),
  
]);

MultiValidator descValditor = MultiValidator([
  MaxLengthValidator(99,
      errorText: "Description must not exceed 99 characters"),
  MinLengthValidator(3, errorText: "Description must be atleast 3 characters")
]);

class CreateTaskPage extends StatefulWidget {
  final Task? task;

  @override
  State<StatefulWidget> createState() => _TaskPageState();
  const CreateTaskPage({Key? key, this.task}) : super(key: key);
}

class _TaskPageState extends State<CreateTaskPage> {
  @override
  CreateTaskPage get widget => super.widget;
  final titleTextFieldController = TextEditingController();
  final descriptionTextFieldController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
            const Text("New Task", style: TitleText()),
            vSpacing20,
            TextFormField(
              decoration: const PrimaryTextFieldDecoration(labelText: "Title"),
              controller: titleTextFieldController,
              validator: titleValditor,
            ),
            vSpacing12,
            TextFormField(
              maxLines: 3,
              decoration:
                  const PrimaryTextFieldDecoration(labelText: "Description"),
              controller: descriptionTextFieldController,
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
                  "Create",
                  style: PrimaryButtonTextStyle(),
                ),
              ),
            ))
          ])),
    ))));
  }

  _onSubmit() async {
   
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        Task t = Task(
            title: titleTextFieldController.text,
            description: descriptionTextFieldController.text);
     
         
        runIfMounted(mounted, ()async{
          Response r = await context.read<RepositoryProvider>().taskRepository.createTodo(t);
            if(r.statusCode == StatusCode.OK){
            runIfMounted(mounted,(){
            ScaffoldMessenger.of(context).showSnackBar(successSnackbar("Task created successfully"));
             } );
           
         }
          });

   
       
       
    }
  }
}
}
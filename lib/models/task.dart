import 'package:practice_app/models/model.dart';
class Task extends Model{
  int? id;
  String title ; 
  String description;
  int isCompleted;
  String timestamp;

Task({
  this.id =0,
  this.title = '',
  this.description = '',
  this.isCompleted = 0,
  this.timestamp=''
});

  factory Task.fromJson(Map<String, dynamic> json){
 
    var parsedDate  = DateTime.parse(json['timestamp']);
    String date= '${parsedDate.year}/${parsedDate.month}/${parsedDate.day}';
    return Task(
       id: json['id'],
       title: json['title'],
       description: json['description'],
       isCompleted: json['isCompleted'],
       timestamp: date
  );
  }
}
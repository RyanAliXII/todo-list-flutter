import 'package:flutter/material.dart';
import 'package:practice_app/components/spacing.dart';



class AddEditBottomModal extends StatelessWidget {
  
  final Function? onDelete;
  final Function? onEdit;

  const AddEditBottomModal({Key? key, this.onDelete, this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(children: buildModalButtons()),
    );
  }

  List<Widget> buildModalButtons() {
    return [
      SizedBox(
          height: 50,
          child: TextButton(
           style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero))),
            onPressed: _edit,
            child: Row(children: [
             hSpacing10,
              const Icon(Icons.edit),
             hSpacing10,
              const Text("Edit")
            ]),
          )),
      SizedBox(
          height: 50,
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero))),
            onPressed: _delete,
            child: Row(children: [
              hSpacing10,
              const Icon(Icons.delete, color: Colors.red),
              hSpacing10,
              const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              )
            ]),
          )),
    ];
  }

  _delete() {
   if(onDelete != null) onDelete!();
}
  _edit() {
   if(onEdit != null) onEdit!();
  }
}

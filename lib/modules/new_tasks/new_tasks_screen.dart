import 'package:flutter/material.dart';
import 'package:todo_app1/shared/components/constants.dart';
import 'package:todo_app1/shared/components/task_item.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index]),
      separatorBuilder: (context, index) => Container(
        margin: EdgeInsets.only(left: 20),
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
      itemCount: tasks.length,
    );
  }
}

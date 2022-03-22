import 'package:flutter/material.dart';
import 'package:todo_app1/widgets/task_item.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return buildTaskItem();
      },
      separatorBuilder: (context, index) {
        return Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        );
      },
      itemCount: 10,
    );
  }
}

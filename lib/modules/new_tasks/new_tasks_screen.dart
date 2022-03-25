import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app1/shared/components/task_item.dart';
import 'package:todo_app1/shared/components/tasks_builder_widger.dart';
import 'package:todo_app1/shared/cubit/cubit.dart';
import 'package:todo_app1/shared/cubit/states.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var tasks = AppCubit.get(context).newTasks;
        //need review ********
        return tasksBuilder(tasks: tasks, context: context, state: state);
      },
    );
  }
}

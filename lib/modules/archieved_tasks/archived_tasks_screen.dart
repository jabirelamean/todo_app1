import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app1/shared/components/task_item.dart';
import 'package:todo_app1/shared/components/tasks_builder_widger.dart';
import 'package:todo_app1/shared/cubit/cubit.dart';
import 'package:todo_app1/shared/cubit/states.dart';

class ArchivedTaskScreen extends StatelessWidget {
  const ArchivedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        var tasks = AppCubit.get(context).arhcivedTasks;
        //need review ********
        return tasksBuilder(tasks: tasks);
      },
    );
  }
}

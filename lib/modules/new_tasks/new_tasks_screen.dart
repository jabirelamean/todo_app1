import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app1/shared/components/task_item.dart';
import 'package:todo_app1/shared/cubit/cubit.dart';
import 'package:todo_app1/shared/cubit/states.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //need review ********
        return AppCubit.get(context).newTasks.length > 0
            ? state == AppGetDatabaseLoadingState()
                ? CircularProgressIndicator()
                : ListView.separated(
                    itemBuilder: (context, index) => buildTaskItem(
                        AppCubit.get(context).newTasks[index], context),
                    separatorBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(left: 20),
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    itemCount: AppCubit.get(context).newTasks.length,
                  )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      'No Tasks To Show, You Could Add Some',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

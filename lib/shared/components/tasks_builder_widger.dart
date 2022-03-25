

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app1/shared/components/task_item.dart';
import 'package:todo_app1/shared/cubit/cubit.dart';
import 'package:todo_app1/shared/cubit/states.dart';

//for the page if it's empty
Widget tasksBuilder({
  @required List<Map>? tasks,
  BuildContext? context,
  AppStates? state,
}){
  return tasks!.length > 0
      ? state == AppGetDatabaseLoadingState()
      ? CircularProgressIndicator()
      : ListView.separated(
    itemBuilder: (context, index) => buildTaskItem(
        tasks[index], context),
    separatorBuilder: (context, index) => Container(
      margin: EdgeInsets.only(left: 20),
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    ),
    itemCount: tasks.length,
  )
      : Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/images/undraw_add_document_re_mbjx.svg',
          fit: BoxFit.contain,
          height: 300,
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
}
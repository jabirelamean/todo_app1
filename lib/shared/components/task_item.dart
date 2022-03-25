import 'package:flutter/material.dart';
import 'package:todo_app1/shared/cubit/cubit.dart';

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction){
      AppCubit.get(context).deleteData(id: model['id']);
    },
    background: Container(color: Colors.red,),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['time']}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updataData(status: 'done', id: model['id']);
            },
            icon: Icon(Icons.check_box, color: Colors.green[700],),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updataData(status: 'archived', id: model['id']);
            },
            icon: Icon(Icons.archive, color: Colors.black45,),
          ),
        ],
      ),
    ),
  );
}

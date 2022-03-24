import 'package:flutter/material.dart';

Widget buildTaskItem(Map model){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text('${model['time']}', style: TextStyle(fontSize: 16),),
        ),
        SizedBox(width: 20,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model['title']}', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
            Text('${model['date']}', style: TextStyle(
                fontSize: 14,
                color: Colors.grey
            ),),
          ],
        ),
      ],
    ),
  );
}
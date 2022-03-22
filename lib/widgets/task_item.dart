import 'package:flutter/material.dart';

Widget buildTaskItem(){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text('12:20 AM', style: TextStyle(fontSize: 16),),
        ),
        SizedBox(width: 20,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Task Title', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
            Text('23 Mar 2022', style: TextStyle(
                fontSize: 14,
                color: Colors.grey
            ),),
          ],
        ),
      ],
    ),
  );
}
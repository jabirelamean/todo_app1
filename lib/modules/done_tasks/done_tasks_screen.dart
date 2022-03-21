import 'package:flutter/material.dart';

class DoneTaskScreen extends StatelessWidget {
  const DoneTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Done Tasks', style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}

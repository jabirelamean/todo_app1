import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app1/modules/archieved_tasks/archived_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:todo_app1/shared/cubit/cubit.dart';
import 'package:todo_app1/shared/cubit/states.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';
import '../shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
// 1- create database
// 2- create tables
// 2- open database
// 3- insert to database
// 4- get from database
// 5- update in database
// 6- delete from database

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          //we put it in a variable just to simplify our work
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.selectedIndex]),
            ),
            body: cubit.screens[cubit.selectedIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetOpen) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet((context) => Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(20),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //title textField
                                  TextFormField(
                                    controller: titleController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      label: Text('Task title'),
                                      prefix: Icon(
                                        Icons.title,
                                        color: Colors.grey,
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  //time textField
                                  TextFormField(
                                    controller: timeController,
                                    keyboardType: TextInputType.none,
                                    onTap: () async {
                                      await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'time must not be empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      label: Text('Task Time'),
                                      prefix: Icon(
                                        Icons.watch_later_outlined,
                                        color: Colors.grey,
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  //date textField
                                  TextFormField(
                                    controller: dateController,
                                    keyboardType: TextInputType.none,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-04-22'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'date must not be empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      label: Text('Task Date'),
                                      prefix: Icon(
                                        Icons.calendar_today,
                                        color: Colors.grey,
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                        cubit.changeBottomSheetState(false, Icons.edit);
                  });
                  cubit.changeBottomSheetState(true, Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 20,
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.selectedIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(label: 'Tasks', icon: Icon(Icons.menu)),
                BottomNavigationBarItem(label: 'Done', icon: Icon(Icons.check)),
                BottomNavigationBarItem(
                    label: 'Archived', icon: Icon(Icons.archive_outlined)),
              ],
            ),
          );
        },
      ),
    );
  }
}

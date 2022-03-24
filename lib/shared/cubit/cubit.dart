import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app1/shared/cubit/states.dart';

import '../../modules/archieved_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //********* begin variables which I listen to them *******//
  int selectedIndex = 0;
  List<Widget> screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen(),
  ];

  List<String> titles = [
    'Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

//********* end variables which I listen to them *******//

//method to change BottomNavBar index
  void changeIndex(int index) {
    selectedIndex = index;
    emit(AppChangeBottomNavBarState());
  }


  //******** begin database operations *****//
  Database? database;
  List<Map> tasks = [];

  void createDatabase() {
    openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          print('db created');
          //creating the table id,title,date, time, status
          database
              .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('Error while creating table ${error.toString()}');
          });
        }, onOpen: (database) {
          getDataFromDatabase(database).then((value) {
             tasks = value;
             emit(AppGetDatabaseState());
          });
          print('database opened');
        }).then((value) {
          database = value;
          emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required title,
    @required String? date,
    @required String? time,
  }) async {
    await database?.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
            print('$value inserited succesfully');
            emit(AppInsertDatabaseState());
            //after insering data and printing it it should get the data now and put it in tasks list
            getDataFromDatabase(database).then((value) {
              tasks = value;
              emit(AppGetDatabaseState());
            });
      }).catchError((error) {
        print('Error while inserting new record ${error.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    //to show a progress indicator we have to listen to the state before getting data \
    //from database to play the circular progress indicator
    emit(AppGetDatabaseLoadingState());

    return await database!.rawQuery('SELECT * FROM tasks');
  }
  // ***** end databasse operations


  bool isBottomSheetOpen = false;
  IconData fabIcon = Icons.edit;
  bool changeBottomSheetState(@required bool? isShown, @required IconData? icon){
    //isShown = isBottomSheetOpen;
    isBottomSheetOpen = isShown!;
   fabIcon = icon!;
    emit(AppChangeBottomSheetState());
    return isShown;
  }
}

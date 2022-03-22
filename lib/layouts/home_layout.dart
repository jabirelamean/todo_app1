import 'package:flutter/material.dart';
import 'package:todo_app1/modules/archieved_tasks/archived_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

// 1- create database
// 2- create tables
// 2- open database
// 3- insert to database
// 4- get from database
// 5- update in database
// 6- delete from database

class _HomeLayoutState extends State<HomeLayout> {
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

  Database? database;

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
      ),
      body: screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertToDatabase();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Tasks',
            icon: Icon(Icons.menu)
          ),
          BottomNavigationBarItem(
            label: 'Done',
              icon: Icon(Icons.check)
          ),
          BottomNavigationBarItem(
            label: 'Archived',
              icon: Icon(Icons.archive_outlined)
          ),
        ],
      ),
    );
  }

  void createDatabase() async{
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version){
        print('db created');
        //creating the table id,title,date, time, status
        database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'
        ).then((value){
          print('table created');
        }).catchError((error){
          print('Error while creating table ${error.toString()}');
        });
      },
      onOpen: (database){
        print('db opened');
      }
    );
  }

  void insertToDatabase(){
    database?.transaction((txn) async{
      txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("first task", "03322", "123", "new")').then((value) {
        print('$value inserted succesfuly}');
      }).catchError((error){
        print('Error while inserting new record ${error.toString()}');
      });
    });
  }
}

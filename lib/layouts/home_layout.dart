import 'package:flutter/material.dart';
import 'package:todo_app1/modules/archieved_tasks/archived_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
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
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetOpen = false;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
      ),
      body: screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (isBottomSheetOpen) {
              if (formKey.currentState!.validate()) {
                insertToDatabase(
                  title: titleController.text,
                  time: timeController.text,
                  date: dateController.text,
                ).then((value) {
                  Navigator.pop(context);
                  isBottomSheetOpen = false;
                });
              }
            } else {
              scaffoldKey.currentState?.showBottomSheet((context) => Container(
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
                  )).closed.then((value) {
                    isBottomSheetOpen = false;
              });
              isBottomSheetOpen = true;
            }
          });
        },
        child: Icon(isBottomSheetOpen ? Icons.add : Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(label: 'Tasks', icon: Icon(Icons.menu)),
          BottomNavigationBarItem(label: 'Done', icon: Icon(Icons.check)),
          BottomNavigationBarItem(
              label: 'Archived', icon: Icon(Icons.archive_outlined)),
        ],
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
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
          getDataFromDatabase(database);
      print('db opened');
    });
  }

  Future insertToDatabase({
    @required title,
    @required String? time,
    @required String? date,
  }) async {
    return await database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        print('$value inserted succesfuly}');
      }).catchError((error) {
        print('Error while inserting new record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) async{
    List<Map> tasks = await database!.rawQuery('SELECT * FROM tasks');
    print(tasks);
  }
}

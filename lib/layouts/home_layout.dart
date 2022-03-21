import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
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
}

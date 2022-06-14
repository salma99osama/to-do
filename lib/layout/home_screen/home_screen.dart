import 'package:flutter/material.dart';
import 'package:to_do/modules/archived_tasks.dart';
import 'package:to_do/modules/done_tasks.dart';
import 'package:to_do/modules/new_tasks.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex=0;
  List<Widget>screens=const [
  NewTasksScreen(),
  DoneTasksScreen(),
  ArchivedTasksScreen()
  ];

  List<String>title=[
    'New tasks',
    'Done tasks',
    'Archived tasks'
  ];

  @override
  void initState() {
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add),),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu,),label: 'Tasks') ,
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline,),label: 'Done tasks') ,
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined,),label: 'archived tasks') ,


        ],
      )
    );
  }

 void createDatabase() async{
    var database = await openDatabase(
        'todo.db',
      version: 1,
      onCreate: (database, version){
          print('database created');
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT )').then((value){
            print('table created');
          }).catchError((error){
            print('error when creating table ${error.toString()}');
          });
      },
      onOpen: (database){
          print('database opened');
    }
    );
 }
}

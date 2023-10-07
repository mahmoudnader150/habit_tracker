import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/modules/add_habit_screen.dart';
import 'package:habit_tracker/modules/progress_screen.dart';

import 'package:habit_tracker/modules/show_habits_screen.dart';
import 'package:habit_tracker/models/user_model.dart';
import 'package:habit_tracker/states/app_states.dart';
import 'package:habit_tracker/states/login_states.dart';
import 'package:sqflite/sqflite.dart';

class  AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());
  static  AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int dailyProgress = 0;


  List<Widget> screens = [
    ProgressScreen(),
    AddHabitScreen(),
    ShowHabitsScreen()
  ];
  String username = "";
  String email = "";
  String password = "";
  User currentUser = User(username: 'username', password:'password', email: "email");

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.add_chart),
        label: 'Progress'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.add,),
        label: 'Add',

    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        label: 'Habits'
    ),
  ];

  void changeIndex(index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Habit> habits = [];


  void setHabit(){

  }





  late Database database;
  void createDatabase() async {
    openDatabase(
      'habit.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
            'CREATE TABLE users (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT )')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
        database
            .execute(
            'CREATE TABLE habits (id INTEGER PRIMARY KEY, name TEXT, description TEXT, user_email TEXT )')
            .then((value) {
          print('table habits created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
      },
    ).then((value) {
      database = value;
      getDataFromDatabase(database);
      getHabitsFromDatabase(database);
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String email,
    required String username,
    required String password,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO users(email, username, password) VALUES("$email", "$username", "$password")',
      ).then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
      return Future(() => null);
    });
  }

  insertHabitsToDatabase({
    required String habitName,
    required String habitDescription,
    required String email,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO habits(name, description, user_email) VALUES("$habitName", "$habitDescription", "$email")',
      ).then((value) {
        print('$value inserted successfully');
        getHabitsFromDatabase(database);
        emit(AppInsertDatabaseState());
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
      return Future(() => null);
    });
  }



  List<User> users=[];
  void getDataFromDatabase(database)  {
    users=[];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM users').then((value){
      value.forEach((element) {
           users.add(User(
               username: element['username'],
               password: element['password'],
               email: element['email'])
           );
      });

      emit(AppGetDatabaseState());
    });
  }

  void getHabitsFromDatabase(database)  {
    habits=[];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM habits').then((value){
      value.forEach((element) {
        habits.add(Habit(
            name: element['name'],
            description: element['description'],
            userEmail: element['user_email'])
        );
      });

      emit(AppGetDatabaseState());
    });
  }
}






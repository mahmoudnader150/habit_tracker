import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/models/user_model.dart';
import 'package:habit_tracker/states/app_states.dart';
import 'package:habit_tracker/states/login_states.dart';
import 'package:sqflite/sqflite.dart';

class  AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());
  static  AppCubit get(context) => BlocProvider.of(context);

  late Database database;
  void createDatabase() async {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String
        print('database created');
        database
            .execute(
            'CREATE TABLE users (id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT )')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
      },
    ).then((value) {
      database = value;
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

}






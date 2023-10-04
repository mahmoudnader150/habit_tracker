import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/states/app_states.dart';
import 'package:habit_tracker/states/login_states.dart';

class  AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());
  static  AppCubit get(context) => BlocProvider.of(context);






}
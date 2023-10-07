import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/states/app_states.dart';
import 'package:habit_tracker/states/login_states.dart';
import 'package:habit_tracker/states/register_states.dart';

class  RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit():super(RegisterInitialState());
  static  RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    (isPassword)?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  bool isRepeatPassword = false;
  void changeRepeatPasswordVisibility(){
    isRepeatPassword = !isRepeatPassword;
    (isPassword)?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
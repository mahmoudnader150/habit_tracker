import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/states/login_states.dart';

class  LoginCubit extends Cubit<LoginStates>{

   LoginCubit():super(LoginInitialState());
  static  LoginCubit get(context) => BlocProvider.of(context);




  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    (isPassword)?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

}
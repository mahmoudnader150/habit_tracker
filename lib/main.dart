import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/app_cubit.dart';
import 'package:habit_tracker/cubit/login_cubit.dart';
import 'package:habit_tracker/modules/home_screen.dart';
import 'package:habit_tracker/modules/login_screen.dart';
import 'package:habit_tracker/states/app_states.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => AppCubit()),
        ],
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home:  LoginScreen(),
            );
          },
        )
    );

  }
}


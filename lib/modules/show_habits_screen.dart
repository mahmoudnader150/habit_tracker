import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/app_cubit.dart';
import 'package:habit_tracker/states/app_states.dart';

class ShowHabitsScreen extends StatelessWidget {
  const ShowHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
           appBar: AppBar(
             backgroundColor: Colors.green,
             title: Text(
                 "Your Habits",
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ),
          body: ,

        );
      },
    );

  }
}

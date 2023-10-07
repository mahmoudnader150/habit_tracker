import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/app_cubit.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/shared/components.dart';
import 'package:habit_tracker/states/app_states.dart';

class EditHabitScreen extends StatelessWidget {

  Habit habit;

  EditHabitScreen({
    super.key,
    required this.habit
  });
  var habitNameController = TextEditingController();
  var habitDescController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[400],
            title: Text(
              "Edit Your Habit",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Habit",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: 25,),
                    defaultFormField(
                        controller: habitNameController,
                        type: TextInputType.text,
                        validate: (value){
                          if(value!.isEmpty){
                            return "Habit Name must not be empty";
                          }
                        },
                        label: "Habit Name",
                        prefix: Icons.title
                    ),
                    SizedBox(height: 25,),
                    defaultFormField(
                        controller: habitDescController,
                        type: TextInputType.text,
                        validate: (value){},
                        label: "Habit Description (optional)",
                        prefix: Icons.view_headline_sharp
                    ),
                    SizedBox(height: 20,),
                    defaultButton(function: ()async{
                      if(formKey.currentState!.validate()) {
                        AppCubit.get(context).deleteHabit(habit);
                        AppCubit.get(context).insertHabitsToDatabase(
                            habitName: habitNameController.text,
                            habitDescription: habitDescController.text,
                            email: AppCubit.get(context).email
                        );
                        print(AppCubit().habits);
                        showToast(text: "Habit Edited");
                      }
                    }, text: "Edit Habit"),
                    SizedBox(height: 20,),
                    defaultButton(function: (){
                      habitNameController.text = habit.name;
                      habitDescController.text = habit.description;
                    }, text: "Reset",
                    ),
                  ],
                ),
              ),
            ),
          ),

        );
      },
    );

  }
}

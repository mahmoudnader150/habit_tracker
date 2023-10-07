import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/app_cubit.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/modules/login_screen.dart';
import 'package:habit_tracker/shared/components.dart';
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
             actions: [
               TextButton(onPressed: (){
                 navigateAndFinish(context, LoginScreen());
               }, child: Text("SIGN OUT",style: TextStyle(color: Colors.white),))
             ],
           ),
          body:  (AppCubit.get(context).habits.length>0)?Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index)=>buildHabitItem(AppCubit.get(context).habits[index]),
                separatorBuilder: (context,index)=>SizedBox(height: 20,),
                itemCount:  AppCubit.get(context).habits.length,
              ),
            ),
          ):
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty_outlined,color: Colors.grey,size: 100,),
                    SizedBox(height: 20,),
                    Text("No Habits added yet",
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 16,
                         color: Colors.grey
                       ),
                    )
                  ],
                ),
              )

        );
      },
    );
  }
  Widget buildHabitItem(Habit habit){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color of the container
        border: Border.all(
          color: Colors.green, // Set the border color
          width: 2.0, // Set the border width
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      height: 100,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  habit.description,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.grey[500]
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
              onPressed:(){

              },
              icon: Icon(Icons.delete,color: Colors.black54,)
          ),
          SizedBox(width: 4,),
          IconButton(
              onPressed:(){

              },
              icon: Icon(Icons.edit_note_outlined,color: Colors.black54,)
          ),
        ],
      ),
    );
  }
}

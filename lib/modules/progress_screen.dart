import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/cubit/app_cubit.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/states/app_states.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({super.key});
  final now = DateTime.now();
  String monthConverter(int month){
    if(month==1)return "JAN";
    if(month==2)return "FEB";
    if(month==3)return "MAR";
    if(month==4)return "APR";
    if(month==5)return "MAY";
    if(month==6)return "JUN";
    if(month==7)return "JUL";
    if(month==8)return "AUG";
    if(month==9)return "SEP";
    if(month==10)return "OCT";
    if(month==11)return "NOV";
    if(month==12)return "DEC";
    return "";
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey[200],
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Material(
                            elevation: 5,
                            shadowColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0), // Customize the border radius
                            ),
                            child: Container(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("HI, ",style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),)
                                    ,Text("${cubit.username} ",style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              )

                            ),
                          ),
                          Spacer(),
                          Material(
                            elevation: 5,
                            shadowColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0), // Customize the border radius
                            ),
                            child: Container(
                                child:Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:Row(
                                    children: [
                                      Text(
                                          "${now.day.toString()}",
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 32,
                                           color: Colors.green[700]
                                         ),
                                      ),
                                      SizedBox(width: 2,),
                                      Column(
                                        children: [
                                          Text(
                                            "${monthConverter(now.month)},",
                                            style: TextStyle(
                                              color: Colors.green, fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          Text(
                                            "${now.year}",
                                            style: TextStyle(
                                                color: Colors.green,
                                              fontWeight: FontWeight.w800
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                )

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Material(
                        elevation: 6,
                        shadowColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0), // Customize the border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            child: HeatMap(
                              datasets: {
                                DateTime(2023, 9, 1): 3,
                                DateTime(2023, 9, 2): 10,
                                DateTime(2023, 9, 3): 7,
                                DateTime(2023, 9, 4): 10,
                                DateTime(2023, 9, 6): 10,
                                DateTime(2023, 9, 7): 7,
                                DateTime(2023, 9, 8): 10,
                                DateTime(2023, 9, 9): 13,
                                DateTime(2023, 9, 13): 6,
                                DateTime(2023, 9, 10): 3,
                                DateTime(2023, 9, 11): 7,
                                DateTime(2023, 9, 12): 10,
                                DateTime(2023, 9, 14): 13,
                                DateTime(2023, 10, 1): 3,
                                DateTime(2023, 10, 2): 6,
                                DateTime(2023, 10, 3): 10,
                                DateTime(2023, 10, 4): 13,
                                DateTime(now.year,now.month,now.day):AppCubit.get(context).dailyProgress
                              },
                              colorMode: ColorMode.opacity,
                              showText: false,
                              scrollable: true,
                              colorsets: {
                                1: Colors.green,
                                3: Colors.green,
                                5: Colors.green,
                                7: Colors.green,
                                9: Colors.green,
                                11: Colors.green,
                                13: Colors.green,
                              },
                              defaultColor: Colors.grey[400],
                              size:18,
                              showColorTip:false,

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index)=>buildHabitItem(AppCubit.get(context).habits[index],context),
                        separatorBuilder: (context,index)=>SizedBox(height: 20,),
                        itemCount:  AppCubit.get(context).habits.length,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget buildHabitItem(Habit habit,context){
    return Material(
      elevation: 3,
      shadowColor: (AppCubit.get(context).doneHabits.contains(habit))?Colors.grey:Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Customize the border radius
      ),
      color: (AppCubit.get(context).doneHabits.contains(habit))?Colors.green[400]:Colors.white,
      child: Container(
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

                  AppCubit.get(context).setHabit(habit);
                },
                icon: (AppCubit.get(context).doneHabits.contains(habit))?Icon(Icons.check_box_outlined,color: Colors.black54,):Icon(Icons.check_box_outline_blank,color: Colors.black54,)
            )
          ],
        ),
      ),
    );
  }
}

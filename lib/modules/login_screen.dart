import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/app_cubit.dart';
import 'package:habit_tracker/cubit/login_cubit.dart';
import 'package:habit_tracker/layout/main_screen.dart';
import 'package:habit_tracker/modules/register_screen.dart';
import 'package:habit_tracker/shared/components.dart';
import 'package:habit_tracker/states/login_states.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool validPassword = false;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        Text(
                            "Login to add new habits",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 30,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty) return "Please enter your email";
                              return null;
                            },
                            label: "Email",
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(height: 20,),
                        defaultFormField(
                            controller:passwordController ,
                            type: TextInputType.visiblePassword,
                            suffix: Icons.visibility_outlined ,
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){

                              }
                            },
                            obscure:LoginCubit.get(context).isPassword,
                            suffixPressed: (){
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            validate: (value)  {
                              if(value!.isEmpty){
                                return 'Password is too short';
                              }
                            },
                            label:  'Password',
                            prefix: Icons.lock_outline
                        ),
                        SizedBox(height: 20,),
                        defaultButton(function: (){
                           if(formKey.currentState!.validate()) {
                             for(int i=0;i<AppCubit.get(context).users.length;i++){
                               if(AppCubit.get(context).users[i].email==emailController.text &&AppCubit.get(context).users[i].password==passwordController.text){
                                 showToast(text: "Welcome ${AppCubit.get(context).users[i].username} to Habit Tracker");
                                 AppCubit.get(context).username = AppCubit.get(context).users[i].username;
                                 AppCubit.get(context).email = AppCubit.get(context).users[i].email;
                                 AppCubit.get(context).password = AppCubit.get(context).users[i].password;
                                 navigateAndFinish(context, MainScreen());
                                 return;
                               }
                             }
                             showToast(text: "Wrong email or password");
                           }
                        }, text: "LOGIN"),
                        Row(
                          children: [
                            Text("Don't have an account?",style: TextStyle(fontWeight: FontWeight.bold),),
                            defaultTextButton(
                                function: (){
                                  navigateTo(context, RegisterScreen());
                                }, text:'register'
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

    );

  }

}

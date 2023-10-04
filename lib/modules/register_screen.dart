import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/app_cubit.dart';
import 'package:habit_tracker/cubit/register_cubit.dart';
import 'package:habit_tracker/modules/login_screen.dart';
import 'package:habit_tracker/shared/components.dart';
import 'package:habit_tracker/states/register_states.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(
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
                        "REGISTER",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      Text(
                        "Fill the form to signIn",
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
                          controller: usernameController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty) return "Please enter your username";
                            return null;
                          },
                          label: "User name",
                          prefix: Icons.title
                      ),
                      SizedBox(height: 20,),
                      defaultFormField(
                          controller:passwordController ,
                          type: TextInputType.visiblePassword,
                          suffix: Icons.visibility_outlined ,

                          obscure:RegisterCubit.get(context).isPassword,
                          suffixPressed: (){
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          validate: (value){
                            if(value!.isEmpty){
                              return 'Password is too short';
                            }
                            if(value!=repeatPasswordController.text){
                              return "Password does not match";
                            }
                          },
                          label:  'Password',
                          prefix: Icons.lock_outline
                      ),
                      SizedBox(height: 20,),
                      defaultFormField(
                          controller:repeatPasswordController  ,
                          type: TextInputType.visiblePassword,
                          suffix: Icons.visibility_outlined ,

                          obscure:RegisterCubit.get(context).isRepeatPassword,
                          suffixPressed: (){
                            RegisterCubit.get(context).changeRepeatPasswordVisibility();
                          },
                          validate: (value){
                            if(value!.isEmpty){
                              return 'Password is too short';
                            }
                            if(value!=passwordController.text){
                              return "Password does not match";
                            }
                          },
                          label:  'Repeat Password',
                          prefix: Icons.lock_outline
                      ),
                      SizedBox(height: 20,),

                      defaultButton(function: ()async{
                        if(formKey.currentState!.validate()) {
                          final query = 'SELECT * FROM users WHERE email = ?';
                          AppCubit.get(context).database;
                          final List<Map<String, dynamic>> rows =  await AppCubit.get(context).database.rawQuery(query, [ '${emailController.text}']);

                          if (rows.isNotEmpty) {
                            showToast(text: "User already signed in");
                          } else {
                            AppCubit.get(context).insertToDatabase(
                                email: emailController.text,
                                username: usernameController.text,
                                password: passwordController.text
                            );
                            navigateTo(context, LoginScreen());
                            showToast(text: "Registered Successfully");
                          }
                        }
                      }, text: "REGISTER"),

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

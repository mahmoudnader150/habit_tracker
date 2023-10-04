import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  required VoidCallback function,
  required String text,
})=> Container(
  width: width,

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: Colors.green[400],
  ),
  child: MaterialButton(
    onPressed:function,
    child: Text(
      "${isUpperCase?text.toUpperCase():text.toLowerCase()}",
      style: TextStyle(
          color: Colors.white
      ),
    ),

  ),
);
//===================================================

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  required String?Function(String?) validate,
  required String label,
  required IconData prefix,
  bool obscure = false,
  VoidCallback? onTap,
  bool isClickable = true,
  IconData? suffix ,
  void Function()?  suffixPressed
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange ,
  validator: validate ,
  obscureText: obscure,
  onTap: onTap,
  enabled: isClickable,

 cursorColor:  Colors.green[400],
  decoration: InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      color: Colors.green[400],
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green), // Green border when focused
    ),

    suffixIcon: IconButton(
      icon: Icon(suffix),
      onPressed: suffixPressed,
      color: Colors.green[400],
    ),
    prefixIcon: Icon(prefix,color: Colors.green[400],),
    border: OutlineInputBorder(
    ),
  ),
);





void navigateTo(context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>widget
    )
);
void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context) =>widget
  ),
      (route)=>false,
);


Widget defaultTextButton({
  required VoidCallback? function,
  required String text
})=>TextButton(
  onPressed: function,
  child: Text(text.toUpperCase(),style: TextStyle(color: Colors.green[600]),),

);

void showToast({
  required String text,
})=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor:  Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );


//enum


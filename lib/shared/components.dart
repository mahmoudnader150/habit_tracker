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
    color: background,
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
  decoration: InputDecoration(
    labelText: label,
    suffixIcon: IconButton(
      icon: Icon(suffix),
      onPressed: suffixPressed,
    ),
    prefixIcon: Icon(prefix),
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
})=>TextButton(onPressed: function, child: Text(text.toUpperCase()),);

void showToast({
  required String text,
})=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor:  Colors.cyanAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );


//enum


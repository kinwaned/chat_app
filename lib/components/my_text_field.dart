import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField({Key? key, this.onChanged,this.controller, required this.hintText, required this.obscureText, required this.suffixIcon}) : super(key: key);

  final controller;
  final String? hintText;
  final bool obscureText;
  final Icon suffixIcon;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        validator: (data){
          if (data!.isEmpty){
            return ('Field is required');
          }
        },
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText:  hintText,
          suffixIcon: suffixIcon,
          suffixIconColor: Colors.grey[400],
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500])
        ),
      ),
    );
  }
}

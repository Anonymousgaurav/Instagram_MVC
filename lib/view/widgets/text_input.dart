import 'package:flutter/material.dart';
import 'package:insta_mvc_demo/utils/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData myIcon;
  final String myLabelText;
  final bool toHide;

  const TextInputField({
    super.key,
    required this.controller,
    required this.myIcon,
    required this.myLabelText,
    this.toHide = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: toHide,
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(
          myIcon,
          color: Colors.blueAccent,
        ),
        labelText: myLabelText,

        /// labelStyle: TextStyle(color: Colors.blueAccent),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: borderColor,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final Size screenSize;
  final String hintText;
  final controller;
  final bool obsecureText;
  final FocusNode focusNode;
  const CustomTextField({super.key, required this.screenSize, required this.hintText, this.controller, required this.obsecureText, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.050),
      child: TextField(
        focusNode: focusNode,
        obscureText: obsecureText,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder:
                 OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CustomColor.bgGrey)),
            focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: CustomColor.mediumDarkGrey)),
            fillColor: CustomColor.lightGrey,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(color: CustomColor.mediumDarkGrey),
            //SsuffixIcon: obsecureText?Icon(Icons.visibility) : Icon(Icons.visibility_off)
          ),
      ),
    );
  }
}


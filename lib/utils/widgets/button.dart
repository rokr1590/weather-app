import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Size screenSize;
  final Function()? onTap;
  final String buttonText;
  final bool isLoading;
  const CustomButton({super.key, required this.screenSize, this.onTap, required this.buttonText, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical :screenSize.height * 0.025,
          horizontal: screenSize.width * 0.032
        ),
        margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.075
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: 
          isLoading ?
          SizedBox(
            height: screenSize.height * 0.025,
            width: screenSize.width * 0.05,
            child: const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ) 
          :
          Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenSize.height * 0.020
            ),
    
          ),
        ),
      ),
    );
  }
}
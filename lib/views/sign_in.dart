import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/images.dart';
import 'package:weather_app/utils/widgets/button.dart';
import 'package:weather_app/view_models/sign_in_vm.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  late Size size;
  late SignInViewModel signInViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      CustomColor.lightStatusBar
    );
    signInViewModel = Provider.of<SignInViewModel>(context,listen: false);

  }
  
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.bgGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height*0.05,),
              //logo
               Icon(
                Icons.sunny ,
                size : size.height * 0.1
              ),
              //Greetings Text
              SizedBox(height: size.height*0.05,),
              Text(
                "Welcome To The Weather App !",
                style: TextStyle(
                  color: CustomColor.darkGrey,
                  fontSize: size.height * 0.024
                ),
              ),
              SizedBox(height: size.height*0.05,),
              //Button to sign in using email and password
              CustomButton(
                screenSize: size,
                onTap: (){},
              ),
              SizedBox(height: size.height*0.05,),
              //Divider
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.052,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: CustomColor.lineColorGrey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(
                          color: CustomColor.mediumDarkGrey,
                          fontSize: size.height * 0.016,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: CustomColor.lineColorGrey,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height*0.05,),
              //Sign in using Google
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      signInViewModel.googleSignin();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.032,
                        vertical: size.height * 0.016
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            CustomImages.googleIcon,
                            height: size.height * 0.042,
                          ),
                          SizedBox(width: size.width * 0.032,),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.018,
                              fontWeight: FontWeight.w600                          ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
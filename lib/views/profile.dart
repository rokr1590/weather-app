import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/widgets/button.dart';
import 'package:weather_app/view_models/sign_in_vm.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late SignInViewModel signInViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signInViewModel = Provider.of<SignInViewModel>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.032,
            horizontal: screenSize.width * 0.064
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signed In as',
                style: TextStyle(
                  fontSize: screenSize.height * 0.016,
                  color: CustomColor.darkGrey
                ),
              ),
              SizedBox(height: screenSize.height * 0.016,),
              Text(
                user.email!,
                style:TextStyle(
                  fontSize: screenSize.height * 0.020,
                  fontWeight: FontWeight.w500
                )
              ),
              SizedBox(height: screenSize.height * 0.016,),
              CustomButton(
                isLoading: false,
                screenSize: screenSize,
                buttonText: "Sign Out",
                onTap: (){
                  signInViewModel.signOut();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
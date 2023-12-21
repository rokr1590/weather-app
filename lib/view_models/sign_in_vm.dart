import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app/models/user_model.dart';

class SignInViewModel extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();
  bool _switchToSignUp = false;
  UserModel? _userModel ;
  bool isLoading = false;
  bool _errorOccured = false;
  //String? _email ;
  //String? _password ;

  bool get switchToSignUp => _switchToSignUp;

  bool get errorOccured => _errorOccured;

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  UserModel? get userModel => _userModel;
  //String? get password => _password;
  
  //String? get email => _email;

  Future<void> googleSignin() async {
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) {
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
     User user = FirebaseAuth.instance.currentUser!;
    
    //setUser(name: user.displayName!, email: user.email!);
    notifyListeners();
  }

  Future emailPasswordSignIn({required String email,required String password}) async{
    try
    {
      toggleLoading(value: true);
      await Future.delayed(const Duration(seconds: 1));
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print("Succcessfull!!!");
      resetToDefault();
    }
    catch(error){
      await Future.delayed(const Duration(seconds: 1));
      toggleLoading(value: false);
      toggleErrorOccured(value: true);
    }
    User user = FirebaseAuth.instance.currentUser!;
    
    //setUser(name: user.displayName!, email: user.email!);
  }

  Future signUp({required String email,required String password}) async {
    try {
      toggleLoading(value: true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      resetToDefault();
    } on FirebaseAuthException catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      toggleLoading(value: false);
      toggleErrorOccured(value: true);
    }
  }

  void setUser({required String name,required String email}){
    _userModel!.displayName = name;
    _userModel!.email = email;

    notifyListeners();
  }

  void toggleSignUp({required bool value}){
    _switchToSignUp = value;
    notifyListeners();
  }

  void toggleLoading({required bool value}){
    isLoading = value;
    notifyListeners();
  }

  void toggleErrorOccured({required bool value}){
    _errorOccured = value;
    notifyListeners();
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  void resetToDefault(){
    _switchToSignUp = false;
    _errorOccured = false;
    isLoading = false;

    notifyListeners();
  }
}
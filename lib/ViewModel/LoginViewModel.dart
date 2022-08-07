import 'package:admin_app/CUSTOMCLASSES/ALL_COLORS.dart';
import 'package:admin_app/view/AuthPages/SignInPage.dart';
import 'package:admin_app/view/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends GetxController{

  final _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  submitLoginForm(String email, String password) async{

    if(email != "" && password != "")
      {
        isLoading.value = true;
        final pref = await SharedPreferences.getInstance();
        _auth.signInWithEmailAndPassword(email: email, password: password)
            .then((value){
          isLoading.value = false;
          Get.snackbar("Congrats! ${email}", "You have logged in successfully!",backgroundColor: greenColor, colorText: whiteColor);
          pref.setString("email", email);
          pref.setString("uid", _auth.currentUser!.uid);
          Get.to(HomePage(),
              transition: Transition.leftToRightWithFade);
        }).catchError((error){
          Get.snackbar("Oops!", error.toString(),backgroundColor: redColor, colorText: whiteColor);
          isLoading.value = false;
        });
      }
    else{
      isLoading.value = false;
      Get.snackbar("All fields are required", 'Please fill all the fields and try again!',backgroundColor: redColor, colorText: whiteColor);
    }
  }

  signOut() async{
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    _auth.signOut();
    Get.offAll(SignInPage(),
    transition: Transition.leftToRightWithFade,
    duration: Duration(seconds: 1));
  }

}
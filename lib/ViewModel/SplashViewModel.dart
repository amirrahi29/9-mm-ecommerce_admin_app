import 'package:admin_app/view/HomePage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/AuthPages/SignInPage.dart';

class SplashViewModel extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkUserLogin();
  }

  checkUserLogin() async{
    final sharedpreferences = await SharedPreferences.getInstance();
    var email = sharedpreferences.get("email");
    var uid = sharedpreferences.get("uid");
    if(email != null && uid != null){
      Future.delayed(Duration(seconds: 3),(){
        Get.offAll(HomePage(),
            transition: Transition.zoom,
            duration: Duration(seconds: 1));
      });
    }
    else{
      Future.delayed(Duration(seconds: 3),(){
        Get.offAll(SignInPage(),
            transition: Transition.zoom,
            duration: Duration(seconds: 1));
      });
    }
  }

}
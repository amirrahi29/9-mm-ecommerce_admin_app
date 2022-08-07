import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountViewModel extends GetxController{

  var email = "".obs;
  var uid = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSavedData();
  }

  getSavedData() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    email.value = sharedPreferences.getString("email").toString();
    uid.value = sharedPreferences.getString("uid").toString();
  }

}
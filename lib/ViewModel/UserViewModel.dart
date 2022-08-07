import 'package:admin_app/model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserViewModel extends GetxController{

  var userList = <UserModel>[].obs;
  var userDummyList = <UserModel>[].obs;
  var isLoadingUser = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllUsers();
  }

  fetchAllUsers() async{
    await FirebaseFirestore.instance.collection("users").get()
    .then((QuerySnapshot snapshot){
      for(var u in snapshot.docs){
        userDummyList.add(UserModel(
          name:u['name'],
          email:u['email'],
          password:u['password'],
          gender:u['gender'],
          dob:u['dob'],
          accountCreated:u['accountCreated'],
          image:u['image'],
        ));
      }
      if(userDummyList != null)
        {
          userList.value = userDummyList;
          isLoadingUser.value=false;
        }
    });
  }

}
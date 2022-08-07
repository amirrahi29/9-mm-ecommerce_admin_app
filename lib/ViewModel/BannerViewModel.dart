import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:admin_app/CUSTOMCLASSES/ALL_COLORS.dart';
import 'package:admin_app/model/BannersModel.dart';
import 'package:admin_app/view/Banners/BannersPage.dart';
import 'package:admin_app/view/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class BannerViewModel extends GetxController{

  var isLoading = false.obs;
  var isListEmpty = false.obs;
  var dummyList = <BannersModel>[].obs;
  var bannerList = <BannersModel>[].obs;

  int get totalBanners => bannerList.length;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllBanners();
  }

  fetchAllBanners() async{
    bannerList.clear();
    dummyList.clear();
    isLoading.value = true;
    await FirebaseFirestore.instance.collection("banners").get()
    .then((QuerySnapshot snapshot){
      isLoading.value = false;
      for(var u in snapshot.docs){
        BannersModel bannersModel = BannersModel(
          uid: u['uid'],
          title: u['title'],
          description: u['description'],
          bannerImage: u['bannerImage'],
          date: u['date']
        );
        dummyList.add(bannersModel);
        dummyList.shuffle();
      }
      bannerList.value = dummyList;
      if(bannerList.length == 0 || bannerList == null){
        isListEmpty.value = true;
      }
    })
    .catchError((error){
      isLoading.value = false;
      Get.snackbar("Something went wrong!", error.toString(),backgroundColor: redColor, colorText: whiteColor);
    });
  }

  addBanner(File imageFile, String title, String description) async{
    isLoading.value = true;
    int uniqueId = DateTime.now().millisecondsSinceEpoch;

    Reference reference = FirebaseStorage.instance.ref();
    UploadTask uploadTask = reference.child("banners/${uniqueId.toString()}").putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String bannerUrl = await snapshot.ref.getDownloadURL();

    if(bannerUrl != null){
      BannersModel bannersModel = BannersModel(
        uid: uniqueId,
        title: title,
        description: description,
        bannerImage: bannerUrl,
        date: DateTime.now().toString(),
      );

      await FirebaseFirestore.instance.collection("banners").doc(uniqueId.toString()).set(bannersModel.toMap())
          .then((value){
        isLoading.value = false;
        Get.snackbar("Congrats!", "Banner added successfully",colorText: whiteColor, backgroundColor: greenColor);
        Get.offAll(HomePage());
      }).catchError((error){
        isLoading.value = false;
        Get.snackbar("Oops!", "Something went wrong, Please try again!",colorText: whiteColor, backgroundColor: redColor);
      });
    }
  }
  deleteBanner(BannersModel bannersModel)async{
    bannerList.remove(bannersModel);
    await FirebaseFirestore.instance.collection("banners").doc(bannersModel.uid.toString()).delete()
    .then((value){
      Get.snackbar("Congrats!", "You have successfully deleted banner.",colorText: whiteColor, backgroundColor: greenColor);
    })
     .catchError((error){
      Get.snackbar("Oops!", error.toString(),colorText: whiteColor, backgroundColor: redColor);
    });
  }

  final colorList = <Color>[
    brownColor,
    greenColor,
    greyColor,
    blueColor,
    pinkColor,
  ];

}
import 'dart:io';
import 'package:admin_app/model/CategoryModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../CUSTOMCLASSES/ALL_COLORS.dart';
import '../view/HomePage.dart';

class CategoryViewModel extends GetxController{

  var isLoading = false.obs;
  var isListEmpty = false.obs;
  var dummyList = <CategoryModel>[].obs;
  var categoryList = <CategoryModel>[].obs;

  int get totalCategories => categoryList.length;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllCategories();
  }

  fetchAllCategories() async{
    dummyList.clear();
    categoryList.clear();
    isLoading.value = true;
    await FirebaseFirestore.instance.collection("categories").get()
        .then((QuerySnapshot snapshot){
      isLoading.value = false;
      for(var u in snapshot.docs){
        CategoryModel catModel = CategoryModel(
            uid: u['uid'],
            title: u['title'],
            description: u['description'],
            catImage: u['catImage'],
            date: u['date']
        );
        dummyList.add(catModel);
        dummyList.shuffle();
      }
      categoryList.value = dummyList;
      if(categoryList.length == 0 || categoryList == null){
        isListEmpty.value = true;
      }
    }).catchError((error){
      isLoading.value = false;
      Get.snackbar("Something went wrong!", error.toString(),backgroundColor: redColor, colorText: whiteColor);
    });
  }

  addCategory(File imageFile, String title, String description) async{
    isLoading.value = true;
    int uniqueId = DateTime.now().millisecondsSinceEpoch;

    Reference reference = FirebaseStorage.instance.ref();
    UploadTask uploadTask = reference.child("categories/${uniqueId.toString()}").putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String catUrl = await snapshot.ref.getDownloadURL();

    if(catUrl != null){
      CategoryModel categoryModel = CategoryModel(
        uid: uniqueId,
        title: title,
        description: description,
        catImage: catUrl,
        date: DateTime.now().toString(),
      );

      await FirebaseFirestore.instance.collection("categories").doc(uniqueId.toString()).set(categoryModel.toMap())
          .then((value){
        isLoading.value = false;
        Get.snackbar("Congrats!", "Category added successfully",colorText: whiteColor, backgroundColor: greenColor);
        Get.offAll(HomePage());
      }).catchError((error){
        isLoading.value = false;
        Get.snackbar("Oops!", "Something went wrong, Please try again!",colorText: whiteColor, backgroundColor: redColor);
      });
    }
  }
  deleteCategory(CategoryModel categoryModel)async{
    categoryList.remove(categoryModel);
    await FirebaseFirestore.instance.collection("categories").doc(categoryModel.uid.toString()).delete()
        .then((value){
      Get.snackbar("Congrats!", "You have successfully deleted category.",colorText: whiteColor, backgroundColor: greenColor);
    })
        .catchError((error){
      Get.snackbar("Oops!", error.toString(),colorText: whiteColor, backgroundColor: redColor);
    });
  }

}
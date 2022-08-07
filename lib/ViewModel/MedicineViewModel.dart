import 'dart:io';
import 'package:admin_app/CUSTOMCLASSES/ALL_COLORS.dart';
import 'package:admin_app/model/MedicineModel.dart';
import 'package:admin_app/view/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class MedicineViewModel extends GetxController{

  var isLoading = false.obs;
  var isListEmpty = false.obs;
  var dummyList = <MedicineModel>[].obs;
  var medicineList = <MedicineModel>[].obs;
  var filteredCategoryList = <MedicineModel>[].obs;
  var filteredSearchList = <MedicineModel>[].obs;

  int get totalMedicines => medicineList.length;
  int get totalFilteredMedicines => filteredCategoryList.length;
  int get totalSearchMedicines => filteredSearchList.length;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllMedicines();
  }

  fetchAllMedicines() async{
    isLoading.value = true;
    await FirebaseFirestore.instance.collection("medicines").get()
        .then((QuerySnapshot snapshot){
      isLoading.value = false;
      for(var u in snapshot.docs){
        MedicineModel medicineModel = MedicineModel(
            uid: u['uid'],
            title: u['title'],
            description: u['description'],
            category: u['category'],
            price: u['price'],
            tax: u['tax'],
            medicineImage: u['medicineImage'],
            date: u['date'],
        );
        dummyList.add(medicineModel);
        dummyList.shuffle();
      }
      medicineList.value = dummyList;
      filteredSearchList.addAll(medicineList);
      if(medicineList.length == 0 || medicineList == null){
        isListEmpty.value = true;
      }
    }).catchError((error){
      isLoading.value = false;
      Get.snackbar("Something went wrong!", error.toString(),backgroundColor: redColor, colorText: whiteColor);
    });
  }

  filteredCategoryMedicineMedicines(String uidd){
    filteredCategoryList.clear();
    for(var u in dummyList){
      if(u.category == uidd){
        MedicineModel medicineModel = MedicineModel(
          uid: u.uid,
          title: u.title,
          description: u.description,
          category: u.category,
          price: u.price,
          tax: u.tax,
          medicineImage: u.medicineImage,
          date: u.date,
        );
        filteredCategoryList.add(medicineModel);
        filteredCategoryList.shuffle();
        if(filteredCategoryList == null){
          isListEmpty.value = true;
        }
      }
    }
  }

  addMedicine(File imageFile, String title, String description, String price, String tax, String categoryId) async{
    isLoading.value = true;
    int uniqueId = DateTime.now().millisecondsSinceEpoch;

    Reference reference = FirebaseStorage.instance.ref();
    UploadTask uploadTask = reference.child("medicines/${uniqueId.toString()}").putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String medicineUrl = await snapshot.ref.getDownloadURL();

      MedicineModel medicineModel = MedicineModel(
        uid: uniqueId,
        title: title,
        description: description,
        category: categoryId,
        price: double.parse(price),
        tax: double.parse(tax),
        medicineImage: medicineUrl,
        date: DateTime.now().toString(),
      );

      await FirebaseFirestore.instance.collection("medicines").doc(uniqueId.toString()).set(medicineModel.toMap())
          .then((value){
        isLoading.value = false;
        Get.snackbar("Congrats!", "Medicine added successfully",colorText: whiteColor, backgroundColor: greenColor);
        Get.offAll(HomePage());
      }).catchError((error){
        isLoading.value = false;
        Get.snackbar("Oops!", "Something went wrong, Please try again!",colorText: whiteColor, backgroundColor: redColor);
      });
    }

  deleteMedicine(MedicineModel medicineModel)async{
    medicineList.remove(medicineModel);
    await FirebaseFirestore.instance.collection("medicines").doc(medicineModel.uid.toString()).delete()
        .then((value){
      Get.snackbar("Congrats!", "You have successfully deleted medicine.",colorText: whiteColor, backgroundColor: greenColor);
    })
        .catchError((error){
      Get.snackbar("Oops!", error.toString(),colorText: whiteColor, backgroundColor: redColor);
    });
  }

  searchMedicine(String text){
    filteredSearchList.clear();
    if(text.isEmpty){
      medicineList.forEach((element) {
        filteredSearchList.add(element);
      });
    }
    else{
      medicineList.forEach((element) {
        if(element.title!.toLowerCase().contains(text))
        {
          filteredSearchList.add(element);
        }
      });
    }
  }
}
import 'package:admin_app/model/MedicineModel.dart';
import 'package:admin_app/model/OrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrdersViewModel extends GetxController{

  var ordersListdummy = <OrderModel>[].obs;
  var ordersList = <OrderModel>[].obs;
  var medicineOrderProductList = <MedicineModel>[].obs;
  var isorderLoading = true.obs;
  var isorderDetailsLoading = false.obs;
  var address = "".obs;
  var name = "".obs;
  var emailId = "".obs;
  var gender = "".obs;
  var photo = "".obs;
  var dob = "".obs;

  fetchAllOrders(String status) async{
    await FirebaseFirestore.instance.collection("orders").get()
    .then((QuerySnapshot snapshot){
      for(var u in snapshot.docs){
        if(status == "2"){
          ordersListdummy.add(OrderModel(
            orderId: u['orderId'],
            totalPrice: u['totalPrice'],
            dateCreated: u['dateCreated'],
            email: u['email'],
            status: u['status'],
          ));
        }
        else{
          if(status == u['status'])
          {
            ordersListdummy.add(OrderModel(
              orderId: u['orderId'],
              totalPrice: u['totalPrice'],
              dateCreated: u['dateCreated'],
              email: u['email'],
              status: u['status'],
            ));
          }
        }
      }
      if(ordersListdummy != null){
        ordersList.value = ordersListdummy;
        isorderLoading.value = false;
      }
    });
  }

  getAllOrderProducts(String orderId) async{
    isorderDetailsLoading.value = true;
    await FirebaseFirestore.instance.collection("orders")
        .doc(orderId).collection("medicines").get()
        .then((QuerySnapshot snapshot){
      medicineOrderProductList.clear();
      for(var u in snapshot.docs){
        FirebaseFirestore.instance.collection("medicines")
            .doc(u['medicineId']).get()
            .then((value) {
          medicineOrderProductList.add(MedicineModel(
            uid: value.data()!['uid'],
            title: value.data()!['title'],
            description: value.data()!['description'],
            category: value.data()!['category'],
            price: value.data()!['price'],
            tax: value.data()!['tax'],
            medicineImage: value.data()!['medicineImage'],
            date: value.data()!['date'],
          ));
        });
      }
      isorderDetailsLoading.value = false;
    });
  }

  getOrderAddress(String email) async{
    await FirebaseFirestore.instance.collection("addresses").get()
        .then((QuerySnapshot snapshot){
          for(var u in snapshot.docs){
            if(u['enabled'] == "true")
            address.value = u['address'];
          }
    });
    await FirebaseFirestore.instance.collection("users").get()
        .then((QuerySnapshot snapshot){
      for(var u in snapshot.docs){
        if(u['email'] == email)
          {
            name.value = u['name'];
            emailId.value = u['email'];
            photo.value = u['image'];
            gender.value = u['gender'];
            dob.value = u['dob'];
          }
      }
    });
  }

}
import 'package:admin_app/CUSTOMCLASSES/ALL_COLORS.dart';
import 'package:admin_app/ViewModel/OrdersViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'OrderDetailPage.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  final ordersViewModel = Get.put(OrdersViewModel());

  var status = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ordersViewModel.fetchAllOrders(status[0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: greenColor,
              title: Text("My orders"),
            ),
            body: Obx(()=>
            ordersViewModel.isorderLoading.value == true?
            Center(
              child: CircularProgressIndicator(color: greenColor,),
            ):ListView.builder(
                itemCount: ordersViewModel.ordersList.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      Get.to(OrderDetailPage(),
                          arguments: [
                            ordersViewModel.ordersListdummy[index].orderId,
                            ordersViewModel.ordersListdummy[index].email,
                          ]);
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[

                        Card(
                          child: Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: <Widget>[

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Text("#${ordersViewModel.ordersList[index].orderId}",
                                          style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.bold
                                          ),),

                                        Text("Date: ${ordersViewModel.ordersList[index].dateCreated}",
                                          style: TextStyle(
                                              fontSize: 12
                                          ),),

                                        SizedBox(height: 16,),

                                        Text("Rs.${ordersViewModel.ordersList[index].totalPrice}/-",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: blackColor,
                                              fontWeight: FontWeight.bold
                                          ),),

                                      ],
                                    ),
                                  ),

                                  Icon(Icons.chevron_right_outlined)

                                ],
                              )
                          ),
                        ),

                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Card(
                            color: ordersViewModel.ordersList[index].status == "1"?
                            greenColor:redColor,
                            elevation: 16,
                            child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(ordersViewModel.ordersList[index].status == "1"?
                                "Success":"Pending",
                                  style: TextStyle(color: whiteColor),)
                            ),
                          ),
                        )

                      ],
                    ),
                  );
                }
            ))
        )
    );
  }
}

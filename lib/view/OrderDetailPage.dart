import 'package:admin_app/ViewModel/OrdersViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CUSTOMCLASSES/ALL_COLORS.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  final orderViewModel = Get.put(OrdersViewModel());
  var orderId = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderViewModel.getAllOrderProducts(orderId[0].toString());
    orderViewModel.getOrderAddress(orderId[1].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: greenColor,
              //title: Text("My order details"),
              title: Text("${orderId[0]}"),
            ),
            body: Obx(()=>
            orderViewModel.isorderDetailsLoading.value == true?
            Center(
              child: CircularProgressIndicator(color: greenColor,),
            ):Stack(
              children: <Widget>[

                ListView.builder(
                    itemCount: orderViewModel.medicineOrderProductList.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Get.to(OrderDetailPage());
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Row(
                                  children: <Widget>[

                                    Container(
                                      height: 50,
                                      width: 50,
                                      child: CachedNetworkImage(
                                        imageUrl: orderViewModel.medicineOrderProductList[index].medicineImage!,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              color: greenColor,
                                            )
                                        ),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    SizedBox(width: 16,),

                                    Expanded(
                                      child: Text("${orderViewModel.medicineOrderProductList[index].title}",
                                        style: TextStyle(
                                            color: blackColor,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ),

                                  ],
                                ),
                                Text("Rs.${orderViewModel.medicineOrderProductList[index].price.toString()}",
                                  style: TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),

                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
                
                Positioned(
                  bottom: 0,
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text("User Details",
                              style: TextStyle(fontSize: 24,
                                  fontWeight: FontWeight.bold),),

                            Divider(color: greenColor,height: 2,),

                            Text("Name: "+orderViewModel.name.value,
                              style: TextStyle(fontSize: 16),),

                            Text("E-mail: "+orderViewModel.emailId.value,
                              style: TextStyle(fontSize: 16),),
                            Text("Gender: "+orderViewModel.gender.value,
                              style: TextStyle(fontSize: 16),),
                            Text("Date of birth: "+orderViewModel.dob.value,
                              style: TextStyle(fontSize: 16),),

                            Divider(),

                            Text("Delivery Address",
                              style: TextStyle(fontSize: 24,
                                  fontWeight: FontWeight.bold),),

                            Divider(color: greenColor,height: 2,),

                            Text(orderViewModel.address.value,
                              style: TextStyle(fontSize: 16),)

                          ],
                        )
                    ),
                  ),
                )
                
              ],
            ))
        )
    );
  }
}

import 'package:admin_app/CUSTOMCLASSES/ALL_COLORS.dart';
import 'package:admin_app/ViewModel/MyAccountViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {

  final myAccountViewModel = Get.put(MyAccountViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: greenColor,
            title: Text("My Account"),
          ),
          body: Obx(()=>SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[

                  Stack(
                    children: <Widget>[

                      Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: NetworkImage("http://1.bp.blogspot.com/-JeYnjWk6boc/UshHfQkuXsI/AAAAAAAAAHM/R9bCIsB1gu4/s1600/emoboy.jpg"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Icon(Icons.camera_alt_outlined,size: 32,color: greenColor,)),
                      )

                    ],
                  ),

                  SizedBox(height: 24,),

                  Container(
                    child: Text("Amir Rahi",style: TextStyle(
                        fontSize: 32,fontWeight: FontWeight.bold
                    ),),
                  ),

                  Container(
                    child: Text(myAccountViewModel.email.toString(),style: TextStyle(
                      fontSize: 16,),),
                  )

                ],
              ),
            ),
          ))
        )
    );
  }
}

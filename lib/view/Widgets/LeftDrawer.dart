import 'package:admin_app/CUSTOMCLASSES/ALL_COLORS.dart';
import 'package:admin_app/view/Banners/BannersPage.dart';
import 'package:admin_app/view/MyAccountPage.dart';
import 'package:admin_app/view/UsersPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/LoginViewModel.dart';
import '../Categories/CategoryPage.dart';
import '../OrdersPage.dart';
import '../Medicines/MedicinesPage.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {

  final loginViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.35,
      child: SafeArea(
          child: Scaffold(
            body: ListView(
              children: <Widget>[

                InkWell(
                  onTap: (){
                    Get.to(MyAccountPage(),
                    transition: Transition.downToUp);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                       Container(
                         height: 130,
                         width: 130,
                         decoration: BoxDecoration(
                           color: greenColor,
                           borderRadius: BorderRadius.circular(100),
                           image: DecorationImage(
                             image: NetworkImage("http://1.bp.blogspot.com/-JeYnjWk6boc/UshHfQkuXsI/AAAAAAAAAHM/R9bCIsB1gu4/s1600/emoboy.jpg"),
                             fit: BoxFit.cover
                           )
                         ),
                       ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[

                              Text("Amir Rahi",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                              SizedBox(width: 8,),
                              Icon(Icons.edit,size: 16,)

                            ],
                          )
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 8,right: 8,bottom: 16),
                            child: Text("amirrahi29@gmail.com")
                        ),

                        Divider(color: greyColor,)

                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){
                    Get.to(OrdersPage(),
                    arguments: [
                      "2"
                    ],
                    transition: Transition.downToUp);
                  },
                  child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          Row(
                            children: <Widget>[

                              Icon(Icons.map_outlined),
                              SizedBox(width: 8,),
                              Expanded(child: Text('Orders',style: TextStyle(fontSize: 16),)),
                              SizedBox(width: 8,),
                              Icon(Icons.chevron_right_outlined),

                            ],
                          ),
                          Divider(color: greyColor,)

                        ],
                      )
                  ),
                ),

                InkWell(
                  onTap: (){
                    Get.to(BannersPage(),
                        transition: Transition.downToUp);
                  },
                  child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          Row(
                            children: <Widget>[

                              Icon(Icons.post_add_outlined),
                              SizedBox(width: 8,),
                              Expanded(child: Text('Banners',style: TextStyle(fontSize: 16),)),
                              SizedBox(width: 8,),
                              Icon(Icons.chevron_right_outlined),

                            ],
                          ),
                          Divider(color: greyColor,)

                        ],
                      )
                  ),
                ),

                InkWell(
                  onTap: (){
                    Get.to(CategoryPage(),
                        transition: Transition.downToUp);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[

                        Row(
                          children: <Widget>[

                            Icon(Icons.category_outlined),
                            SizedBox(width: 8,),
                            Expanded(child: Text('Categories',style: TextStyle(fontSize: 16),)),
                            SizedBox(width: 8,),
                            Icon(Icons.chevron_right_outlined),

                          ],
                        ),
                        Divider(color: greyColor,)

                      ],
                    )
                  ),
                ),

                InkWell(
                  onTap: (){
                    Get.to(MedicinesPage(),
                        transition: Transition.downToUp,);
                  },
                  child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          Row(
                            children: <Widget>[

                              Icon(Icons.medical_services_outlined),
                              SizedBox(width: 8,),
                              Expanded(child: Text('Medicines',style: TextStyle(fontSize: 16),)),
                              SizedBox(width: 8,),
                              Icon(Icons.chevron_right_outlined),

                            ],
                          ),
                          Divider(color: greyColor,)

                        ],
                      )
                  ),
                ),

                InkWell(
                  onTap: (){
                    Get.to(UsersPage(),
                        transition: Transition.downToUp);
                  },
                  child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          Row(
                            children: <Widget>[

                              Icon(Icons.person_outline_outlined),
                              SizedBox(width: 8,),
                              Expanded(child: Text('Users',style: TextStyle(fontSize: 16),)),
                              SizedBox(width: 8,),
                              Icon(Icons.chevron_right_outlined),

                            ],
                          ),
                          Divider(color: greyColor,)

                        ],
                      )
                  ),
                ),

                InkWell(
                  onTap: (){
                    print('share');
                  },
                  child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          Row(
                            children: <Widget>[

                              Icon(Icons.share_outlined),
                              SizedBox(width: 8,),
                              Expanded(child: Text('Share',style: TextStyle(fontSize: 16),)),
                              SizedBox(width: 8,),
                              Icon(Icons.chevron_right_outlined),

                            ],
                          ),
                          Divider(color: greyColor)

                        ],
                      )
                  ),
                ),

                InkWell(
                  onTap: (){
                    print('rate and review');
                  },
                  child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          Row(
                            children: <Widget>[

                              Icon(Icons.star_border_outlined),
                              SizedBox(width: 8,),
                              Expanded(child: Text('Rate on playstore',style: TextStyle(fontSize: 16),)),
                              SizedBox(width: 8,),
                              Icon(Icons.chevron_right_outlined),

                            ],
                          ),
                          Divider(color: greyColor)

                        ],
                      )
                  ),
                ),

                InkWell(
                  onTap: (){
                    loginViewModel.signOut();
                  },
                  child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          Row(
                            children: <Widget>[

                              Icon(Icons.exit_to_app),
                              SizedBox(width: 8,),
                              Expanded(child: Text('SignOut',style: TextStyle(fontSize: 16),)),
                              SizedBox(width: 8,),
                              Icon(Icons.chevron_right_outlined),

                            ],
                          ),
                          Divider(color: greyColor,)

                        ],
                      )
                  ),
                )

              ],
            )
          )
      ),
    );
  }
}

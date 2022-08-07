import 'package:admin_app/ViewModel/BannerViewModel.dart';
import 'package:admin_app/ViewModel/CategoryViewModel.dart';
import 'package:admin_app/ViewModel/MedicineViewModel.dart';
import 'package:admin_app/view/Banners/BannersPage.dart';
import 'package:admin_app/view/Categories/CategoryPage.dart';
import 'package:admin_app/view/Medicines/MedicinesPage.dart';
import 'package:admin_app/view/Medicines/SearchMedicinePage.dart';
import 'package:admin_app/view/OrdersPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../CUSTOMCLASSES/ALL_COLORS.dart';
import '../CUSTOMCLASSES/ALL_IMAGES.dart';
import 'Medicines/FilterCategoryMedicine.dart';
import 'Widgets/LeftDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final bannerViewModel = Get.put(BannerViewModel());
  final categoryViewModel = Get.put(CategoryViewModel());
  final medicineViewModel = Get.put(MedicineViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          drawer: LeftDrawer(),
          appBar: AppBar(
            backgroundColor: greenColor,
            title: Container(
              height: 100,
              child: Image.asset(whiteLogo),
            ),
            actions: [
              InkWell(
                onTap: (){
                  Get.to(SearchMedicinePage(),
                  transition: Transition.rightToLeftWithFade);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.search,color: whiteColor,),
                ),
              )
            ],
          ),
          body: Obx(()=>Container(
            margin: EdgeInsets.all(8),
            child: ListView(
              children: <Widget>[

                myPichart(),
                myCatgories(),
                myBanners(),
                myMedicines(),

                InkWell(
                  onTap: (){
                    Get.to(MedicinesPage(),
                        transition: Transition.rightToLeftWithFade);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(24)
                        ),
                        child: Text("See more",style: TextStyle(color: whiteColor,fontSize: 16),),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                height: 100,
                width: 150,
                color: brownColor,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    InkWell(
                      onTap:(){
                        Get.to(OrdersPage(),
                            arguments: [
                              "1"
                            ],
                            transition: Transition.circularReveal,
                        duration: Duration(seconds: 1));
                      },
                      child: Card(
                        elevation: 6,
                        color: greenColor,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("Orders Completed",
                          style: TextStyle(color: whiteColor),),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        Get.to(OrdersPage(),
                            arguments: [
                              "0"
                            ],
                            transition: Transition.circularReveal,
                        duration: Duration(seconds: 1));
                      },
                      child: Card(
                        elevation: 6,
                        color: redColor,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("Orders Pending",
                            style: TextStyle(color: whiteColor),),
                        ),
                      ),
                    )

                  ],
                ),
              )

            ],
          ),
        ),
    );
  }

  Widget myPichart(){
    return PieChart(
      dataMap: {
        "Medicines": medicineViewModel.totalMedicines.toDouble(),
        "Categories": categoryViewModel.totalCategories.toDouble(),
        "Banners": bannerViewModel.totalBanners.toDouble(),
        "Orders": 2,
        "Users": 4,
      },
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 1.8,
      colorList: bannerViewModel.colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      centerText: "9|mm",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        //legendShape: _BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }

  Widget myCatgories(){
    return Obx(()=>Container(
      margin: EdgeInsets.only(top: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[

                  Expanded(child: Text("Categories (${categoryViewModel.totalCategories})",style: TextStyle(fontSize: 24),)),
                  InkWell(
                      onTap: (){
                        Get.to(CategoryPage(),
                            transition: Transition.rightToLeftWithFade);
                      },
                      child: Text("view more",style: TextStyle(fontSize: 20),)),

                ],
              )
          ),
          Divider(),
          SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[

                  for(int i = 0; i<categoryViewModel.categoryList.length; i++)
                    InkWell(
                      onTap: (){
                        Get.to(FilterFilterCategoryMedicineMedicine(),
                            transition: Transition.rightToLeftWithFade,
                            arguments: [
                              categoryViewModel.categoryList[i].uid.toString(),
                              categoryViewModel.categoryList[i].title!
                            ]);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 50,
                            padding: EdgeInsets.only(left: 8,right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: categoryViewModel.categoryList[i].catImage!,
                                placeholder: (context, url) =>
                                    Center(
                                        child: CircularProgressIndicator(
                                          color: greenColor,
                                        )),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(categoryViewModel.categoryList[i].title!),
                          ),
                        ],
                      ),
                    ),

                ],
              )
          ),

          InkWell(
            onTap: (){
              Get.to(CategoryPage(),
                  transition: Transition.rightToLeftWithFade);
            },
            child: Column(
              children: [
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(24)
                  ),
                  child: Text("See more",style: TextStyle(color: whiteColor,fontSize: 16),),
                ),
              ],
            ),
          ),

          SizedBox(height: 16,)

        ],
      ),
    ));
  }

  Widget myBanners(){
    return Obx(()=>Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[

                  Expanded(child: Text("Banners (${bannerViewModel.totalBanners})",style: TextStyle(fontSize: 24),)),
                  InkWell(
                      onTap: (){
                        Get.to(BannersPage(),
                            transition: Transition.rightToLeftWithFade);
                      },
                      child: Text("view more",style: TextStyle(fontSize: 20),)),

                ],
              )
          ),
          Divider(),
          SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[

                  for(int i = 0; i<bannerViewModel.bannerList.length; i++)
                    Container(
                      width: 250,
                      padding: EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: CachedNetworkImage(
                          imageUrl: bannerViewModel.bannerList[i].bannerImage!,
                          placeholder: (context, url) =>
                              Center(
                                  child: CircularProgressIndicator(
                                    color: greenColor,
                                  )),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                ],
              )
          )

        ],
      ),
    ));
  }

  Widget myMedicines(){
    return Container(
      margin: EdgeInsets.only(top: 24,bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[

                  Expanded(child: Text("Medicines (${medicineViewModel.totalMedicines})",style: TextStyle(fontSize: 24),)),
                  InkWell(
                      onTap: (){
                        Get.to(MedicinesPage(),
                            transition: Transition.rightToLeftWithFade);
                      },
                      child: Text("view more",style: TextStyle(fontSize: 20),)),

                ],
              )
          ),
          Divider(),
          SizedBox(
              height: 350,
              child: GridView.count(
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[

                  if(medicineViewModel.medicineList.length >= 4)
                  for(int i = 0; i<4; i++)
                    Card(
                      elevation: 6,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[

                            Container(
                              height: 70,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl: medicineViewModel.medicineList[i].medicineImage!,
                                placeholder: (context, url) =>
                                    Center(
                                        child: CircularProgressIndicator(
                                          color: greenColor,
                                        )),
                              ),
                            ),

                            SizedBox(height: 16,),

                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text("Rs."+medicineViewModel.medicineList[i].price!.toString()),
                            ),

                            Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 8),
                              child: Text(medicineViewModel.medicineList[i].title!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),

                          ],
                        ),
                      ),
                    )

                  else
                    Container(
                      alignment: Alignment.center,
                      child: Text("No medicines!"),
                    )
                ],
              )
          ),

        ],
      ),
    );
  }
}

import 'package:admin_app/ViewModel/BannerViewModel.dart';
import 'package:admin_app/ViewModel/MedicineViewModel.dart';
import 'package:admin_app/view/Banners/AddBanner.dart';
import 'package:admin_app/view/Categories/AddCategory.dart';
import 'package:admin_app/view/Medicines/AddMedicine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../CUSTOMCLASSES/ALL_COLORS.dart';
import '../../ViewModel/CategoryViewModel.dart';

class MedicinesPage extends StatefulWidget {
  const MedicinesPage({Key? key}) : super(key: key);

  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {

  final medicineViewModel = Get.put(MedicineViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(()=>Scaffold(
          appBar: AppBar(
            backgroundColor: greenColor,
            title: Text("Medicines (${medicineViewModel.totalMedicines})"),
          ),
          body: LoadingOverlay(
            isLoading: medicineViewModel.isLoading.value,
            child: medicineViewModel.isListEmpty.value == true?
            Center(
              child: Text("No medicines found!"),
            )
                :GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: <Widget>[

                  for(int i = 0; i<medicineViewModel.medicineList.length; i++)
                    Card(
                      elevation: 6,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[

                            Stack(
                              children: <Widget>[

                                Container(
                                  height: 70,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    child: CachedNetworkImage(
                                      imageUrl: medicineViewModel.medicineList[i].medicineImage!,
                                      placeholder: (context, url) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                color: greenColor,
                                              )),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                        onTap: (){
                                          medicineViewModel.deleteMedicine(medicineViewModel.medicineList[i]);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.all(4),
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                color: redColor,
                                                borderRadius: BorderRadius.circular(100)
                                            ),
                                            child: Icon(Icons.close,color: Colors.white,size: 20,))))

                              ],
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
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: greenColor,
            onPressed: (){
              Get.to(AddMedicine(),
                  transition: Transition.downToUp);
            },
            child: Icon(Icons.add),
          ),
        ),)
    );
  }
}

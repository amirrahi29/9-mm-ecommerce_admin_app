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

class SearchMedicinePage extends StatefulWidget {
  const SearchMedicinePage({Key? key}) : super(key: key);

  @override
  _SearchMedicinePageState createState() => _SearchMedicinePageState();
}

class _SearchMedicinePageState extends State<SearchMedicinePage> {

  final medicineViewModel = Get.put(MedicineViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(()=>Scaffold(
          appBar: AppBar(
            backgroundColor: greenColor,
            title: Row(
              children: <Widget>[

                Expanded(
                  child: TextField(
                    style: TextStyle(color: whiteColor),
                    cursorColor: whiteColor,
                    decoration: InputDecoration(
                      hintText: 'Search here....',
                      suffix: Icon(Icons.close),
                      hintStyle: TextStyle(
                          color: whiteColor
                      ),
                    ),
                    onChanged: (value){
                      medicineViewModel.searchMedicine(value);
                    },
                  ),
                )

              ],
            )
          ),
          body: LoadingOverlay(
            isLoading: medicineViewModel.isLoading.value,
            child: medicineViewModel.isListEmpty.value == true?
            Center(
              child: Text("No medicines found!"),
            )
                :ListView.builder(
                itemCount: medicineViewModel.filteredSearchList.length,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          Stack(
                            children: <Widget>[

                              Container(
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  child: CachedNetworkImage(
                                    imageUrl: medicineViewModel.filteredSearchList[index].medicineImage!,
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
                                        medicineViewModel.deleteMedicine(medicineViewModel.filteredSearchList[index]);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.all(4),
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: Icon(Icons.close,color: Colors.white,size: 24,))))

                            ],
                          ),

                          Divider(),

                          Container(
                            alignment: Alignment.centerRight,
                            child: Text("Rs."+medicineViewModel.filteredSearchList[index].price!.toString(),
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ),

                          Container(
                            child: Text(medicineViewModel.filteredSearchList[index].title!,
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),

                          Container(
                            child: Text(medicineViewModel.filteredSearchList[index].description!,
                              style: TextStyle(fontSize: 16),),
                          )

                        ],
                      ),
                    ),
                  );
                }
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

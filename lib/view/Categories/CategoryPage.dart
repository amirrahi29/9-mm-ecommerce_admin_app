import 'package:admin_app/ViewModel/BannerViewModel.dart';
import 'package:admin_app/view/Banners/AddBanner.dart';
import 'package:admin_app/view/Categories/AddCategory.dart';
import 'package:admin_app/view/Medicines/FilterCategoryMedicine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../CUSTOMCLASSES/ALL_COLORS.dart';
import '../../ViewModel/CategoryViewModel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  final categoryViewModel = Get.put(CategoryViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(()=>Scaffold(
          appBar: AppBar(
            backgroundColor: greenColor,
            title: Text("Categories (${categoryViewModel.totalCategories})"),
          ),
          body: LoadingOverlay(
            isLoading: categoryViewModel.isLoading.value,
            child: categoryViewModel.isListEmpty.value == true?
            Center(
              child: Text("No categories found!"),
            )
                :ListView.builder(
                itemCount: categoryViewModel.categoryList.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Get.to(FilterFilterCategoryMedicineMedicine(),
                      transition: Transition.rightToLeftWithFade,
                      arguments: [
                        categoryViewModel.categoryList[index].uid.toString(),
                        categoryViewModel.categoryList[index].title!
                      ]);
                    },
                    child: Card(
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
                                      imageUrl: categoryViewModel.categoryList[index].catImage!,
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
                                          categoryViewModel.deleteCategory(categoryViewModel.categoryList[index]);
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

                            Container(
                              child: Text(categoryViewModel.categoryList[index].title!,
                                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                            )

                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: greenColor,
            onPressed: (){
              Get.to(AddCategory(),
                  transition: Transition.downToUp);
            },
            child: Icon(Icons.add),
          ),
        ),)
    );
  }
}

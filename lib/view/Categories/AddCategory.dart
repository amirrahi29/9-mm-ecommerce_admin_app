import 'dart:io';
import 'dart:math';
import 'package:admin_app/ViewModel/BannerViewModel.dart';
import 'package:admin_app/ViewModel/CategoryViewModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../CUSTOMCLASSES/ALL_COLORS.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  final categoryViewModel = Get.put(CategoryViewModel());

  getImageFromGallery() async{
    // Pick an image
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickedFile!.path);
      print("imageFile: ${imageFile}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(()=>LoadingOverlay(
          isLoading: categoryViewModel.isLoading.value,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: greenColor,
                title: Text("Categories"),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      imageFile == null?
                      InkWell(
                        onTap: (){
                          getImageFromGallery();
                        },
                        child: Container(
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: greyColor,
                            // image: DecorationImage(
                            //     image: FileImage(imageFile!),
                            //     fit: BoxFit.cover
                            // )
                          ),
                          child: imageFile==null?Icon(Icons.camera_alt_outlined,size: 100,color: greenColor,):Container(),
                        ),
                      ):
                      InkWell(
                        onTap: (){
                          getImageFromGallery();
                        },
                        child: Container(
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: greyColor,
                              image: DecorationImage(
                                  image: FileImage(imageFile!),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),

                      SizedBox(height: 24,),

                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Category title',
                            prefixIcon: Icon(Icons.title),
                            hintText: 'Category title'
                        ),
                      ),

                      SizedBox(height: 16,),

                      TextField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Category descriptions',
                            prefixIcon: Icon(Icons.list_alt),
                            hintText: 'Category descriptions'
                        ),
                      ),

                      SizedBox(height: 16,),

                      InkWell(
                        onTap: (){
                          if(imageFile != null && titleController.text != null && descriptionController.text != null){
                            categoryViewModel.addCategory(imageFile!,titleController.text,descriptionController.text);
                          }
                          else{
                            Get.snackbar("All fields are required!", "Please try again!",colorText: whiteColor, backgroundColor: redColor);
                          }
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: greenColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text("Submit",
                            style: TextStyle(fontSize: 24,
                                fontWeight: FontWeight.bold,color: whiteColor),),
                        ),
                      ),

                    ],
                  ),
                ),
              )
          ),
        ))
    );
  }
}
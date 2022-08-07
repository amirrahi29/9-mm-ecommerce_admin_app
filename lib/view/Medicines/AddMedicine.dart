import 'dart:io';
import 'dart:math';
import 'package:admin_app/ViewModel/BannerViewModel.dart';
import 'package:admin_app/ViewModel/CategoryViewModel.dart';
import 'package:admin_app/ViewModel/MedicineViewModel.dart';
import 'package:admin_app/model/CategoryModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../CUSTOMCLASSES/ALL_COLORS.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final taxController = TextEditingController();
  final priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  final medicineViewModel = Get.put(MedicineViewModel());
  final categoryViewModel = Get.put(CategoryViewModel());
  String? _chosenValue;

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
          isLoading: medicineViewModel.isLoading.value,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: greenColor,
                title: Text("Medicines"),
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
                            labelText: 'Medicine title',
                            prefixIcon: Icon(Icons.title),
                            hintText: 'Medicine title'
                        ),
                      ),

                      SizedBox(height: 16,),

                      TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Price',
                            prefixIcon: Icon(Icons.monetization_on),
                            hintText: 'Price'
                        ),
                      ),

                      SizedBox(height: 16,),

                      TextField(
                        controller: taxController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Tax',
                            prefixIcon: Icon(Icons.monetization_on),
                            hintText: 'Tax'
                        ),
                      ),

                      SizedBox(height: 16,),
                      Container(
                        padding: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 8),
                        decoration: BoxDecoration(
                            color: greyColor,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: DropdownButton(
                          value: _chosenValue,
                          underline: SizedBox(),
                          isExpanded: true,
                          dropdownColor: brownColor,
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: greenColor,
                          ),
                          items: categoryViewModel.categoryList.map((CategoryModel catModel) {
                            return new DropdownMenuItem<String>(
                              value: catModel.uid.toString(),
                              child: new Text(catModel.title!),
                            );
                          }).toList(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          hint: Text('Select category',style: TextStyle(color: greenColor),),
                          onChanged: (val) {
                            setState(() {
                              _chosenValue = val.toString();
                              print(val);
                            });
                          },
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
                            labelText: 'Medicine descriptions',
                            prefixIcon: Icon(Icons.list_alt),
                            hintText: 'Medicine descriptions'
                        ),
                      ),

                      SizedBox(height: 16,),

                      InkWell(
                        onTap: (){
                          if(imageFile != null && titleController.text != null && descriptionController.text != null
                          && priceController.text != null && taxController.text != null && _chosenValue != null){
                            medicineViewModel.addMedicine(imageFile!,titleController.text,descriptionController.text,
                            priceController.text,taxController.text,_chosenValue!);
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
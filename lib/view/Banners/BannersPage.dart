import 'package:admin_app/ViewModel/BannerViewModel.dart';
import 'package:admin_app/view/Banners/AddBanner.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../CUSTOMCLASSES/ALL_COLORS.dart';

class BannersPage extends StatefulWidget {
  const BannersPage({Key? key}) : super(key: key);

  @override
  _BannersPageState createState() => _BannersPageState();
}

class _BannersPageState extends State<BannersPage> {

  final bannerViewModel = Get.put(BannerViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(()=>Scaffold(
          appBar: AppBar(
            backgroundColor: greenColor,
            title: Text("Banners (${bannerViewModel.totalBanners})"),
          ),
          body: LoadingOverlay(
            isLoading: bannerViewModel.isLoading.value,
            child: bannerViewModel.isListEmpty.value == true?
                Center(
                  child: Text("No banners found!"),
                )
                :ListView.builder(
              itemCount: bannerViewModel.bannerList.length,
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
                                   imageUrl: bannerViewModel.bannerList[index].bannerImage!,
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
                                     bannerViewModel.deleteBanner(bannerViewModel.bannerList[index]);
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
                            child: Text(bannerViewModel.bannerList[index].title!,
                              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
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
              Get.to(AddBanner(),
                  transition: Transition.downToUp);
            },
            child: Icon(Icons.add),
          ),
        ),)
    );
  }
}

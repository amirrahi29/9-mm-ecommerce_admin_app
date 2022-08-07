import 'package:admin_app/ViewModel/UserViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CUSTOMCLASSES/ALL_COLORS.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  final userViewModel = Get.put(UserViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: greenColor,
            title: Text("Users"),
          ),
          body: Obx(()=>
          userViewModel.isLoadingUser.value == true?
          Center(
            child: CircularProgressIndicator(color: greenColor,),
          )  :
          ListView.builder(
            itemCount: userViewModel.userList.length,
              itemBuilder: (context, index){
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[

                        Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            child: CachedNetworkImage(
                              imageUrl: userViewModel.userList[index].image!,
                              placeholder: (context, url) =>
                                  Center(
                                      child: CircularProgressIndicator(
                                        color: greenColor,
                                      )),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(width: 16,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              child: Text(userViewModel.userList[index].name!,
                              style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16),),
                            ),
                            Container(
                              child: Text(userViewModel.userList[index].email!),
                            )

                          ],
                        )

                      ],
                    ),
                  ),
                );
              }
          )
          ),
        )
    );
  }
}
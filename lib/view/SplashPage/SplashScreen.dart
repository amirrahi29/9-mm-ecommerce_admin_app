import 'package:admin_app/ViewModel/SplashViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CUSTOMCLASSES/ALL_IMAGES.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final splashViewModel = Get.put(SplashViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashViewModel.checkUserLogin();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.height/3,
                child: Image.asset(greenLogo)
            ),
          )
        )
    );
  }
}

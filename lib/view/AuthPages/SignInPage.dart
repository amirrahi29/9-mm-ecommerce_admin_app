import 'package:admin_app/CUSTOMCLASSES/ALL_COLORS.dart';
import 'package:admin_app/CUSTOMCLASSES/ALL_IMAGES.dart';
import 'package:admin_app/ViewModel/LoginViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(()=>LoadingOverlay(
          isLoading: loginViewModel.isLoading.value,
          child: Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImage),
                    fit: BoxFit.fitWidth
                  )
                ),
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        Container(
                          height: 250,
                          child: Image.asset(greenLogo),
                        ),

                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: greenColor
                                )
                              ),
                              labelText: 'E-mail id',
                              prefixIcon: Icon(Icons.email),
                              hintText: 'E-mail id'
                          ),
                        ),

                        SizedBox(height: 16,),

                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: greenColor
                                )
                              ),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password'
                          ),
                        ),

                        SizedBox(height: 16,),

                        InkWell(
                          onTap: (){
                            loginViewModel.submitLoginForm(emailController.text,passwordController.text);
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text("Sign In",
                              style: TextStyle(fontSize: 24,
                                  fontWeight: FontWeight.bold,color: whiteColor),),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              )
          ),
        ))
    );
  }
}

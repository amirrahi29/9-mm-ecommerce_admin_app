import 'package:flutter/material.dart';
import '../CUSTOMCLASSES/ALL_COLORS.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: greenColor,
            title: Text("Users"),
          ),
          body: Center(
            child: Text("Users"),
          ),
        )
    );
  }
}
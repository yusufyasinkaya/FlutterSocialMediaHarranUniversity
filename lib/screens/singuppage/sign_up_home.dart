import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/singuppage/sing_up_page.dart';

class HomePageSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageSignUp();
}

class _HomePageSignUp extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.purpleAccent.shade200,
              Colors.blueAccent.shade400,
              Colors.lightBlueAccent,
            ],
          ),
        ),
        child: SignUp(),
      ),
    );
  }
}

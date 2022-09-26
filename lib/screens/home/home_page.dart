import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/login/login.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Login(),
      ),
    );
  }
}

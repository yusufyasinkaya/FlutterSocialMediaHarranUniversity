import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/kulupsayfasi/kulup_sayfasi.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State {
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
        child: GirisSayfasi(),
      ),
    );
  }
}

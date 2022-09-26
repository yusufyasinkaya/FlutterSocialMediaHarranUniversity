import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/mainScreens/firebase_file.dart';

class UserPho extends StatelessWidget {
  final FirebaseFile file;
  const UserPho({Key? key, required this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
      ),
      body: Image.network(
        file.url,
        height: double.infinity,
      ),
    );
  }
}

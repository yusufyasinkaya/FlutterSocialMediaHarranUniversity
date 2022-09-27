import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/mainScreens/firebase_file.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;
  const ImagePage({Key? key, required this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(file.name,style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Image.network(
        file.url,
        height: double.infinity,
      ),
    );
  }
}

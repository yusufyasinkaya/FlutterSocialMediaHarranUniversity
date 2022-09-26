import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/providers/user_provider.dart';

class PhotoZoom extends StatelessWidget {
  final snap;

  const PhotoZoom({Key? key, required this.snap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<UserProvider>(context);
    if (viewmodel.user == null) {
      return Center(
        child: Text(""),
      );
    } else
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          title: Text(
            snap['username'],
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Image.network(
          snap['postUrl'],
          height: double.infinity,
        ),
      );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Duyuru extends StatefulWidget {
  Duyuru();
  @override
  State createState() => _Duyuru();
}

class _Duyuru extends State {
  _Duyuru();
  @override
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
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('etkinlik').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
              children: snapshot.data!.docs.map((document) {
            return SizedBox(
                child: Container(
              padding: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 8,
              child: Text(
                document.data()["a"].toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ));
          }).toList());
        },
      ),
    ));
  }
}

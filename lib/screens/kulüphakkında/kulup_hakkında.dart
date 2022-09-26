import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Hakkinda extends StatefulWidget {
  @override
  State createState() => _Hakkinda();
}

class _Hakkinda extends State {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: MediaQuery.of(context).size.height,
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
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Image.asset(
            "fotolar/foto.jpeg",
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          heightFactor: 1.5,
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('hakkinda').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Expanded(
              child: ListView(
                  children: snapshot.data!.docs.map((document) {
                return SizedBox(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      document.data()["b"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ));
              }).toList()),
            );
          },
        ),
      ]),
    )));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/mainScreens/firebase_file.dart';
import 'package:tiyatrokulubu/screens/mainScreens/strorage.dart';

class Filmler extends StatefulWidget {
  @override
  State createState() => _Filmler();
}

class _Filmler extends State {
  late Future<List<FirebaseFile>> futureFiles;
  @override
  void initState() {
    super.initState();
    futureFiles = Storage.listAll("filmler/");
  }

  Widget build(BuildContext context) {
    Widget buildFile(BuildContext context, FirebaseFile file) => Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: Text(
                "Bu haftaki film önerimiz",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(
                child: Image.network(
              file.url,
              width: MediaQuery.of(context).size.width * 0.45,

              //height: 100,
              fit: BoxFit.fill,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Center(
              child: Text(
                file.name,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('film').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.only(top: 30),
                            child: Text(
                              document.data()["c"].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList());
              },
            ),
          ],
        );
    return Scaffold(
        body: Container(
      child: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Some error occured!'),
                );
              } else {
                final files = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              final file = files[index];
                              return buildFile(context, file);
                            }))
                  ],
                );
              }
          }
        },
      ),
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
    ));
  }
}

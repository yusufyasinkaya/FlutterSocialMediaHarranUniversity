import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/mainScreens/firebase_file.dart';
import 'package:tiyatrokulubu/screens/mainScreens/image.dart';
import 'package:tiyatrokulubu/screens/mainScreens/strorage.dart';

class Fotos extends StatefulWidget {
  @override
  State createState() => _Fotos();
}

class _Fotos extends State {
  late Future<List<FirebaseFile>> futureFiles;
  @override
  void initState() {
    super.initState();
    futureFiles = Storage.listAll("etkinlikler/");
  }

  Widget build(BuildContext context) {
    Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
          leading: Image.network(
            file.url,
            width: 120,
            //height: 100,
            fit: BoxFit.fill,
          ),
          title: Text(
            file.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ImagePage(file: file),
          )),
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

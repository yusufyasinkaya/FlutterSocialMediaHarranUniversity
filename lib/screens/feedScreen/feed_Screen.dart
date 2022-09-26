import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/post_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FeedScreen extends StatefulWidget {
  @override
  State createState() => _FeedScreen();
}

class _FeedScreen extends State {
  Image appLogo = new Image(
    image: new ExactAssetImage("assets/images/AppLogo.png"),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'fotolar/hru.png',
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
          backgroundColor: Colors.black38,
          child: ListView(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.5),
              children: [
                Text(
                  "Bize ulaşın:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Whatsapp:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    TextButton(
                        onPressed: () => launchUrlString(
                            'https://chat.whatsapp.com/LlVYB5CDNGAA3Rf3s7jgJk'),
                        child: Text(
                          "Buraya Tıklayın",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "İnstagram:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    TextButton(
                        onPressed: () => launchUrlString(
                            'https://www.instagram.com/hrutiyatrokulubu/'),
                        child: Text(
                          "@hrutiyatrokulubu",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ))
                  ],
                )
              ])),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          /* if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }*/
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Postcard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

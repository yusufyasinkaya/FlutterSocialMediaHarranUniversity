import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiyatrokulubu/firestroeMethods/firestroe_meethods.dart';

import '../../models/providers/user_provider.dart';
import '../utils/commentCard/comment_card.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({Key? key, required this.snap});
  @override
  State createState() => _CommentScreen();
}

class _CommentScreen extends State<CommentScreen> {
  final TextEditingController _commentCont = TextEditingController();
  @override
  initState() {
    super.initState();
    print(widget.snap);
  }

  @override
  void dispose() {
    super.dispose();
    _commentCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Yorumlar",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap)
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => CommentCard(
                    snap: (snapshot.data! as dynamic).docs[index].data(),
                  ));
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  viewmodel.getUser.photoUrl,
                ),
                radius: 10,
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 8),
                      child: TextField(
                        controller: _commentCont,
                        decoration: InputDecoration(
                          hintText: "Yorum yapın",
                          border: InputBorder.none,
                        ),
                      ))),
              InkWell(
                onTap: () async {
                  FirestoreMethods().postComment(
                      widget.snap,
                      _commentCont.text,
                      viewmodel.getUser.uid,
                      viewmodel.getUser.username,
                      viewmodel.getUser.photoUrl);
                  setState(() {
                    _commentCont.text = "";
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    'Gönder',
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

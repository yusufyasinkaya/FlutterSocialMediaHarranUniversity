import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiyatrokulubu/firestroeMethods/firestroe_meethods.dart';
import 'package:tiyatrokulubu/models/providers/user_provider.dart';
import 'package:tiyatrokulubu/screens/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  @override
  State createState() => _AddPostScreen();
}

class _AddPostScreen extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController descController = TextEditingController();
  bool _isLoading = false;
  void postImage(String uid, String username, String profileImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods()
          .uploadPost(descController.text, _file!, uid, profileImage, username);
      if (res == "Succes") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Paylaşıldı', context);
        clearImage();
      } else {
        showSnackBar(res, context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectedImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (contex) {
          return SimpleDialog(
            title: const Text("Bir gönderi oluşturun"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Fotoğraf çekin'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  print(file.runtimeType);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Fotoğraf seçin'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('İptal'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<UserProvider>(context);
    return _file == null
        ? Center(
            child: IconButton(
                icon: Icon(Icons.upload),
                onPressed: () => _selectedImage(context)),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: clearImage,
              ),
              title: Text(
                "Fotoğraf Yükleyin",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () => postImage(viewmodel.getUser.uid,
                        viewmodel.getUser.username, viewmodel.getUser.photoUrl),
                    child: Text(
                      "Paylaş",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),
                SizedBox(
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(viewmodel.getUser.photoUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: descController,
                        decoration: InputDecoration(
                          hintText: 'Bir şeyler yazın...',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          )),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}

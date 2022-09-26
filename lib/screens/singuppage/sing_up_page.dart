import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiyatrokulubu/screens/instagramLayout/instagram_layout.dart';
import 'package:tiyatrokulubu/screens/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../authMethods/auth_methods.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUp();
}

class _SignUp extends State {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioCont = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  Uint8List?
      _image; //uYGULAMADA GORUNEN DIGER RESIMLER GIBI DEFAULT RESMI UINT NESNESI OLARAK TANIMLA
  bool isLoading = false;
  void selectedImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    print("ÇALIŞTI 1");
    if (_image == null) {
      _image = (await NetworkAssetBundle(Uri.parse(
                  "https://firebasestorage.googleapis.com/v0/b/tiyatro-c307e.appspot.com/o/prfilePics%2Fengellenmek_1211392_m.png?alt=media&token=23eb0cb4-3ae2-4b5a-b562-6e46e687701d"))
              .load(
                  "https://firebasestorage.googleapis.com/v0/b/tiyatro-c307e.appspot.com/o/prfilePics%2Fengellenmek_1211392_m.png?alt=media&token=23eb0cb4-3ae2-4b5a-b562-6e46e687701d"))
          .buffer
          .asUint8List();
      if (_image == null) {
        print("NULL DEGER");
      }
    }

    String res = await AuthMethods().singUpUser(
        email: _numberController.text,
        password: _passController.text,
        userName: _usernameController.text,
        bio: _bioCont.text,
        file: _image!);
    setState(() {
      isLoading = true;
    });
    print("ÇALIŞTI 2");
    if (res != 'Succes') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Şifre en az altı karakter olmalı veya kayıtlı kullanıcı"),
      ));

      isLoading = false;
    } else {
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
      Route route = PageRouteBuilder(
          pageBuilder: (context, animation, animationTime) {
            return InstagramLayoutScreen();
          },
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (context, animation, animationTime, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          });

      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Kayıt Ol",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/tiyatro-c307e.appspot.com/o/prfilePics%2Fengellenmek_1211392_m.png?alt=media&token=23eb0cb4-3ae2-4b5a-b562-6e46e687701d'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        selectedImage();
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.black26,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 7,
                        blurRadius: 10,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.1),
                      )
                    ]),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: "Kullanıcı Adı Girin",
                      prefixIcon: Icon(Icons.person),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 7,
                        blurRadius: 10,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.1),
                      )
                    ]),
                child: TextField(
                  controller: _bioCont,
                  decoration: InputDecoration(
                      hintText: "İsim ve Soy İsminizi Girin",
                      prefixIcon: Icon(Icons.person_pin),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 7,
                        blurRadius: 10,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.1),
                      )
                    ]),
                child: TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                      hintText: "E-Posta Girin",
                      prefixIcon: Icon(Icons.mail),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 7,
                        blurRadius: 10,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.1),
                      )
                    ]),
                child: TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Şifre Oluşturun",
                      prefixIcon: Icon(Icons.password),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                )),
            SizedBox(
              height: 68,
              width: 250,
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                    onPressed: signUpUser,

                    // FirebaseAuth.instance.createUserWithEmailAndPassword(email: _numberController.text, password: _passController.text).then((value)
                    //  {
                    /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Kayıt Başarılı. Yönlendiriliyorsunuz..."),
                      ));
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>GirisSayfasi()));
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Hesap Oluşturulmadı! Bilgileri kontrol edin"),
                      ));});*/
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, right: 40, left: 40),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.black26,
                              ),
                            )
                          : Text(
                              "Kayıt Ol",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            RichText(
                text: TextSpan(
              text: "İnstagramdan bizi takip edin: ",
              style: TextStyle(
                color: Colors.cyan.shade50,
                fontSize: 20,
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Center(
                heightFactor: 1.5,
                child: GestureDetector(
                  child: Image.asset(
                    "fotolar/insta.png",
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  onTap: () =>
                      launch('https://www.instagram.com/hrutiyatrokulubu/'),
                )),
          ],
        ));
  }
}

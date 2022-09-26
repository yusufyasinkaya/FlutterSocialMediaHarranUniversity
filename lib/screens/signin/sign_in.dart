import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiyatrokulubu/screens/instagramLayout/instagram_layout.dart';
import 'package:tiyatrokulubu/screens/profile/profile_screen.dart';
import 'package:tiyatrokulubu/screens/singuppage/sign_up_home.dart';
import 'package:tiyatrokulubu/screens/utils/global_variables.dart';
import 'package:tiyatrokulubu/secureStorage/secure_storage.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final SecSto secureStore = SecSto();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "fotolar/foto.jpeg",
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              heightFactor: 1.5,
            ),
            Text(
              "Merhaba",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Lütfen Giriş Yapın",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
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
                      prefixIcon: Icon(Icons.person),
                      hintText: "E-posta girin",
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
              height: MediaQuery.of(context).size.height * 0.015,
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
                  obscureText: true,
                  controller: _passController,
                  decoration: InputDecoration(
                      hintText: "Şifre",
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
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            SizedBox(
              height: 68,
              width: 250,
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });

                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _numberController.text,
                              password: _passController.text)
                          .then((value) async {
                        await secureStore.writeSecureData(
                            'email', _numberController.text);
                        await secureStore.writeSecureData(
                            'pass', _passController.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Giriş Başarılı"),
                        ));
                        Route route = PageRouteBuilder(
                            pageBuilder: (context, animation, animationTime) {
                              return InstagramLayoutScreen();
                            },
                            transitionDuration: Duration(seconds: 1),
                            transitionsBuilder:
                                (context, animation, animationTime, child) {
                              animation = CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.elasticInOut);
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                                alignment: Alignment.center,
                              );
                            });
                        ProfileScreen tmp =
                            homeScreensItems[4] as ProfileScreen;
                        tmp.uid = FirebaseAuth.instance.currentUser!.uid;

                        Navigator.pushAndRemoveUntil(
                            context, route, (route) => false);
                        /*  Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (context, animation, animationTime) {
                                  return GirisSayfasi();
                                },
                                transitionDuration: Duration(seconds: 1),
                                transitionsBuilder:
                                    (context, animation, animationTime, child) {
                                  animation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.elasticInOut);
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                    alignment: Alignment.center,
                                  );
                                }));*/
                      }).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Hesap bulunamadı! Bilgileri kontrol edin veya üye olun"),
                        ));
                      });
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, right: 40, left: 40),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Giriş Yapın",
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            RichText(
                text: TextSpan(
                    text: "Üye değil misin? ",
                    style: TextStyle(
                      color: Colors.cyan.shade50,
                      fontSize: 20,
                    ),
                    children: [
                  TextSpan(
                      text: "Üye Ol",
                      style: TextStyle(
                        color: Colors.cyan.shade100,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => HomePageSignUp()))
                ]))
          ],
        ));
  }
}

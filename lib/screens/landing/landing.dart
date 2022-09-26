import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/home/home_page.dart';
import 'package:tiyatrokulubu/screens/kulupsayfasi/kulup_material.dart';

import 'package:tiyatrokulubu/screens/singuppage/sing_up_page.dart';
import 'package:tiyatrokulubu/secureStorage/secure_storage.dart';

class Landing extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Landing();

}
class _Landing extends State{
  SecSto secSto = SecSto();
  SignUp signUp = SignUp();
  bool _isLoading=true;
  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      return CircularProgressIndicator();

    }else {
      secSto.readData("email").then((mail) {
        if (mail != null) {
          secSto.readData("pass").then((pass) {
            if (pass != null) {
              FirebaseAuth.instance.signInWithEmailAndPassword(email: mail, password: pass).then((value) {
                secSto.writeSecureData('email', mail);
                secSto.writeSecureData('pass', pass);
              });
              return Home();
            } else {
              return HomePage();
            }
          });
        } else {
          return HomePage();
        }
      });
      setState((){});
      return CircularProgressIndicator();
    }
  }

}
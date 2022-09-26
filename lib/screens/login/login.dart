import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/instagramLayout/instagram_layout.dart';

import 'package:tiyatrokulubu/screens/signin/sign_in_home.dart';
import 'package:tiyatrokulubu/secureStorage/secure_storage.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  SecSto sto = SecSto();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "fotolar/foto.jpeg",
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            heightFactor: 1.5,
          ),
          Text(
            "Tiyatro Kulübü'ne Hoş Geldiniz",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          Text(
            "Uygulamaya Giriş Yapın",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 68,
            width: 250,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        (await sto.readData('email') == null &&
                                await sto.readData('pass') == null)
                            ? PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, animationTime) {
                                  return HomePageSign();
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
                                })
                            : PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, animationTime) {
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
                                }));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, right: 40, left: 40),
                    child: Text(
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
          )
        ],
      ),
    );
  }
}

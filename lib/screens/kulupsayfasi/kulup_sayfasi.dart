import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tiyatrokulubu/screens/kul%C3%BCphakk%C4%B1nda/kulup_hakk%C4%B1nda.dart';
import 'package:tiyatrokulubu/screens/mainScreens/duyurular.dart';
import 'package:tiyatrokulubu/screens/mainScreens/film.dart';
import 'package:tiyatrokulubu/screens/mainScreens/fotod.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  State createState() => _GirisSayfasi();
}

class _GirisSayfasi extends State {
  List sayfalar = [
    Duyuru(),
    Fotos(),
    Hakkinda(),
    Filmler(),
  ];
  int currentIndex = 0;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: sayfalar[currentIndex],
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.black,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_sharp),
                label: "Duyurular",
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.photo),
                  label: "Etkinlik Galerisi",
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.theater_comedy),
                  label: "Kulüp Hakkında",
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.movie_creation_outlined),
                  label: "Haftalık Film",
                  backgroundColor: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

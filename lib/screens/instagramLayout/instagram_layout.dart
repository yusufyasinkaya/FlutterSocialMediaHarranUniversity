import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/utils/global_variables.dart';

class InstagramLayoutScreen extends StatefulWidget {
  @override
  _InstagramLayoutScreen createState() => _InstagramLayoutScreen();
}

class _InstagramLayoutScreen extends State {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void nagivationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreensItems,
        controller: pageController,
        onPageChanged: onPageChange,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        height: MediaQuery.of(context).size.height * 0.07,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? Colors.black : Colors.black26,
              ),
              label: "",
              backgroundColor: Theme.of(context).colorScheme.primary),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? Colors.black : Colors.black26,
              ),
              label: "",
              backgroundColor: Theme.of(context).colorScheme.primary),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline,
                color: _page == 2 ? Colors.black : Colors.black26,
              ),
              label: "",
              backgroundColor: Theme.of(context).colorScheme.primary),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.theater_comedy,
                color: _page == 3 ? Colors.black : Colors.black26,
              ),
              label: "",
              backgroundColor: Theme.of(context).colorScheme.primary),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? Colors.black : Colors.black26,
              ),
              label: "",
              backgroundColor: Theme.of(context).colorScheme.primary),
        ],
        onTap: nagivationTapped,
      ),
    );
  }
}

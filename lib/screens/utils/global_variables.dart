import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/screens/addPostScreens/add_post_screens.dart';
import 'package:tiyatrokulubu/screens/feedScreen/feed_Screen.dart';
import 'package:tiyatrokulubu/screens/kulupsayfasi/kulup_material.dart';
import 'package:tiyatrokulubu/screens/profile/profile_screen.dart';
import 'package:tiyatrokulubu/screens/searchScreen/search_screen.dart';

List<Widget> homeScreensItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Home(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

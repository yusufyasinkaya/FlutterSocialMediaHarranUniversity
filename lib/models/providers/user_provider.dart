import 'package:flutter/material.dart';
import 'package:tiyatrokulubu/authMethods/auth_methods.dart';

import '../users.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    refreshUser();
  }
  User? _user;
  User? get user => _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;
  Future<void> refreshUser() async {
    print("user" + _user.toString());
    User user = await _authMethods.getUserDetails();
    _user = user;
    print("user" + _user.toString());
    notifyListeners();
  }
}

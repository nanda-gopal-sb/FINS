import 'package:fins/firebase/auth.dart';
import 'package:fins/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  AppUser? _user;
  final AuthMethods _authMethods = AuthMethods();

  AppUser get getUser => _user!;

  Future<void> refreshUser() async {
    AppUser user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}

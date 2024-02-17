import 'package:fins/app_theme.dart';
import 'package:fins/home_page.dart';
import 'package:fins/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const FINS());
}

class FINS extends StatelessWidget {
  const FINS({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while checking login status
        } else {
          final bool isLoggedIn = snapshot.data ?? false;
          return MaterialApp(
            theme: getAppTheme(),
            home: isLoggedIn ? const HomePage() : const LoginPage(),
          );
        }
      },
    );
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}

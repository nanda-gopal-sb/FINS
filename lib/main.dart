import 'package:fins/app_theme.dart';
import 'package:fins/page/home.dart';
import 'package:fins/page/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          bool isLoggedIn = snapshot.data ?? false;
          return MaterialApp(
            theme: getAppTheme(),
            home: isLoggedIn ? const HomePage() : const LoginPage(),
          );
        }
      },
    );
  }

  Future<bool> checkLoginStatus() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getBool('isLoggedIn') ?? false;
    return false;
  }
}

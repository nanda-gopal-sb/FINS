import 'package:fins/page/home.dart';
import 'package:flutter/material.dart';

void goToHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const HomePage(),
    ),
    (route) => false,
  );
}

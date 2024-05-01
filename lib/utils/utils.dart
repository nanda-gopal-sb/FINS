import 'package:fins/page/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void goToHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const HomePage(),
    ),
    (route) => false,
  );
}

/// retrives data from realtime db snapshot
///
/// returns 0 if it finds no record of it (using 0 is useful because most realtime fields are numbers)
dynamic parseData(dynamic type, DataSnapshot snap, String child) {
  if (snap.hasChild(child)) {
    return type.parse(snap.child(child).value.toString());
  }
  return 0;
}

showSnackBar(BuildContext context, String res) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(res),
    ),
  );
}

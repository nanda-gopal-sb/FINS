import 'package:fins/firebase/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUp({
    required String email,
    required String name,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Error occured";

    try {
      if (email.isNotEmpty && name.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String url =
            await StorageMethods().uploadImage("profilePicture", file, "dir");

        await _firestore.collection("users").doc(cred.user?.uid).set({
          "uid": cred.user?.uid,
          "email": email,
          "photoURL": url,
        });

        res = "done";
      }
    } catch (err) {}
    return res;
  }
}

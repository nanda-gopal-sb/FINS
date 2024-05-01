import 'package:fins/firebase/storage.dart';
import 'package:fins/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String name,
    required String password,
    required String confirmPassword,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (confirmPassword != password) {
        return "Password doesnt match";
      } else if (email.isEmpty || name.isEmpty || password.isEmpty) {
        res = "Please enter all the fields";
      } else {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = cred.user!.uid;
        String photoUrl = "";

        try {
          photoUrl =
              await StorageMethods().uploadImageToStorage('$uid/profile', file);
        } catch (err) {
          // bypass incase photo upload fails
        }

        AppUser user = AppUser(
          uid: cred.user!.uid,
          email: email,
          name: name,
          photoURL: photoUrl,
        );

        await _firestore.collection("users").doc(uid).set(user.toJSON());
        var fa = FirebaseAuth.instance.currentUser!;
        DatabaseReference userSensorDataRef =
            FirebaseDatabase.instance.ref(fa.uid);
        userSensorDataRef.child("isConnected").set("false");
        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<AppUser> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return AppUser.fromSnap(snap);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

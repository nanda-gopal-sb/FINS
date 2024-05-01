import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String name;
  final String photoURL;
  const AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoURL,
  });

  Map<String, dynamic> toJSON() => {
        "uid": uid,
        "email": email,
        "name": name,
        "photoURL": photoURL,
      };

  static AppUser fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = {
      "uid": "",
      "email": "",
      "name": "",
      "photoURL": "",
    };
    try {
      snapshot = snap.data() as Map<String, dynamic>;
    } catch (err) {
      print(snap.data());
    }

    return AppUser(
      uid: snapshot["uid"],
      email: snapshot["email"],
      name: snapshot["name"],
      photoURL: snapshot["photoURL"],
    );
  }
}

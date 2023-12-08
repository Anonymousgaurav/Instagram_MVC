import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? uid;
  String? image;

  UserModel(
      {required this.email,
      required this.uid,
      required this.name,
      required this.image});

  Map<String, dynamic> toJson() =>
      {"name": name, "email": email, "uid": uid, "ProfilePic": image};

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<dynamic, String>;
    return UserModel(
        email: snapshot['email'],
        uid: snapshot['uid'],
        name: snapshot['name'],
        image: snapshot['ProfilePic']);
  }
}

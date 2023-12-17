import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsModel {
  String username;
  String comments;
  final datePub;
  List likes;
  String profilePic;
  String uid;
  String id;

  CommentsModel({
    required this.username,
    required this.comments,
    required this.datePub,
    required this.likes,
    required this.profilePic,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comments': comments,
        'datePub': datePub,
        'likes': likes,
        'profilePic': profilePic,
        'uid': uid,
        'id': id,
      };

  static CommentsModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CommentsModel(
      username: snapshot['username'],
      comments: snapshot['comments'],
      datePub: snapshot['datePub'],
      likes: snapshot['likes'],
      profilePic: snapshot['profilePic'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}

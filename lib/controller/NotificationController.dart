import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/models/NotificationModel.dart';

class NotificationController extends GetxController {
  final Rx<List<NotificationModel>> _notification =
      Rx<List<NotificationModel>>([]);

  List<NotificationModel> get notification => _notification.value;

  fetchNotifications() async {
    _notification.bindStream(FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection('notification')
        .snapshots()
        .map((QuerySnapshot query) {
      List<NotificationModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(NotificationModel.fromSnap(element));
      }
      return retVal;
    }));
  }

  //TODO: check the flow of this method
  likeNotification(String vid) async {
    Get.snackbar("liking", "");
    try {
      /// Access videosCollection from firebase firestore
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('videos').doc(vid).get();

      /// Accessing userDocumentCollection from FirebaseFirestore
      DocumentSnapshot userdoc = await FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .get();

      /// Accessing notificationCollection from FirebaseFirestore
      var notColl = await FirebaseFirestore.instance
          .collection('User')
          .doc((doc.data() as dynamic)["uid"])
          .collection('notification')
          .get();

      Get.snackbar("liking5", "");

      NotificationModel noti = NotificationModel(
          username: (userdoc.data() as dynamic)['name'],
          msg: "liked your video",
          datePub: DateTime.now(),
          profilePic: (userdoc.data() as dynamic)['ProfilePic'],
          uid: FirebaseAuth.instance.currentUser!.uid.toString(),
          id: 'notif ${notColl.docs.length}');

      Get.snackbar("liking6", "");

      await FirebaseFirestore.instance
          .collection('User')
          .doc((doc.data() as dynamic)["uid"])
          .collection('notification')
          .doc('notif ${notColl.docs.length + 1}')
          .set(noti.toJson());

      Get.snackbar("liked", "");
    } catch (e) {
      if (kDebugMode) {
        print('notification Error===================${e}');
      }
    }
  }
}

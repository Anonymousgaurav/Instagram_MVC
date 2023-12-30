import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/models/UserModel.dart';

class SearchController extends GetxController {
  final Rx<List<UserModel>> _searchUsers = Rx<List<UserModel>>([]);

  List<UserModel> get searchedUsers => _searchUsers.value;

  searchUser(String query) async {
    _searchUsers.bindStream(FirebaseFirestore.instance
        .collection("User")
        .where("name", isGreaterThanOrEqualTo: query)
        .snapshots()
        .map((QuerySnapshot queryRes) {
      List<UserModel> retVal = [];
      for (var element in queryRes.docs) {
        retVal.add(UserModel(
            email: element['email'],
            uid: element['uid'],
            name: element['name'],
            image: element['ProfilePic']));
      }
      return retVal;
    }));
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_mvc_demo/models/UserModel.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  File? profilePic;
  late Rx<User?> _user;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Error login", "Please fill all fields");
      }
    } catch (e) {
      Get.snackbar("Error Occured", e.toString());
    }
  }

  _setInitialView(User? user) {}

  void SignUp(String name, String email, String password, File? image) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String dp = await _uploadProPic(image);

        UserModel user = UserModel(
            email: email, uid: credential.user!.uid, name: name, image: dp);
        await FirebaseFirestore.instance
            .collection('User')
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error in creating user', 'please fill all blanks');
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error Occured", e.toString());
    }
  }

  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profilePics")
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imgDwnUrl = await snapshot.ref.getDownloadURL();
    return imgDwnUrl;
  }

  pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      final img = File(image!.path);
      profilePic = img;
    } catch (e) {
      print("error during image pic---------${e}");
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}

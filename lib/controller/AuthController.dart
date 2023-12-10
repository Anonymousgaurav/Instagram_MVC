import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/models/UserModel.dart';
import 'package:insta_mvc_demo/utils/CamUtils.dart';
import 'package:insta_mvc_demo/view/screens/HomeScreen.dart';

import '../view/screens/LoginScreen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  static File? profilePic;

  late Rx<User?> _user;

  User get user => _user.value!;

  static RxString profileImage = "".obs;

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

  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void signUp(String name, String email, String password, File? image) async {
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
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar("Error Occurred", e.toString());
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

  signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
  }

  static launchPicker(BuildContext context) async {
    CamUtils.openSelector(context, _processSelectedImage);
  }

  static void _processSelectedImage(File? img) async {
    if (img != null) {
      updateProfile(img.path, img);
    } else {
      if (kDebugMode) {
        print('cancelledImage');
      }
    }
  }

  static void updateProfile(String profileImg, File imgFile) {
    profilePic = imgFile;
    profileImage.value = profileImg;
  }
}

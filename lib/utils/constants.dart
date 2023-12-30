import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_mvc_demo/view/screens/NotificationScreen.dart';
import 'package:insta_mvc_demo/view/screens/ProfileScreen.dart';
import 'package:insta_mvc_demo/view/screens/ScrollReelsScreen.dart';
import 'package:insta_mvc_demo/view/screens/SearchScreen.dart';
import 'package:insta_mvc_demo/view/screens/VideoAddScreen.dart';

getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];

const bgColour = Colors.black;
var button = Colors.red[400];
const borderColor = Colors.blueAccent;

var uid = FirebaseAuth.instance.currentUser!.uid;

var pageIndex = [
  ScrollReelsScreen(),
  SearchScreen(),
  const VideoAddScreen(),
  const NotificationScreen(),
  ProfileScreen(uid: uid),
];

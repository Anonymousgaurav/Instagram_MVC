import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];

const bgColour = Colors.black;
var button = Colors.red[400];
const borderColor = Colors.grey;

var uid = FirebaseAuth.instance.currentUser!.uid;

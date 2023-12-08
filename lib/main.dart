import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:insta_mvc_demo/view/screens/SignUpScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Instagram',

      /// theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColour),
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

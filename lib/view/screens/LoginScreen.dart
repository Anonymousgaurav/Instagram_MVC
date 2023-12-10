import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/controller/AuthController.dart';
import 'package:insta_mvc_demo/utils/DeviceUtils.dart';
import 'package:insta_mvc_demo/view/screens/SignUpScreen.dart';
import 'package:insta_mvc_demo/view/styles/LoginScreenStyles.dart';
import 'package:insta_mvc_demo/view/widgets/text_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: _DIMENS.WHITE_SPACING,
            ),
            Container(
              height: DeviceUtils.fractionHeight(context, fraction: 15.0),
              margin: const EdgeInsets.symmetric(
                horizontal: _DIMENS.MARGIN_HORIZONTAL,
              ),
              child: TextInputField(
                controller: _emailController,
                myLabelText: "Email",
                myIcon: Icons.email,
              ),
            ),
            const SizedBox(
              height: _DIMENS.WHITE_SPACING,
            ),
            Container(
              height: DeviceUtils.fractionHeight(context, fraction: 15.0),
              margin: const EdgeInsets.symmetric(
                horizontal: _DIMENS.MARGIN_HORIZONTAL,
              ),
              child: TextInputField(
                controller: _passwordController,
                myLabelText: "Password",
                myIcon: Icons.lock,
                toHide: true,
              ),
            ),
            const SizedBox(
              height: _DIMENS.WHITE_SPACING,
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                controller.login(
                  _emailController.text,
                  _passwordController.text,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                  "Login",
                  style: LoginScreenStyles.loginButton,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(SignUpScreen());
              },
              child: Text(
                "New User? Click Here",
                style: LoginScreenStyles.signUpText,
              ),
            )
          ],
        ),
      ),
    );
  }
}

abstract class _DIMENS {
  static const WHITE_SPACING = 25.0;
  static const MARGIN_HORIZONTAL = 40.0;
}

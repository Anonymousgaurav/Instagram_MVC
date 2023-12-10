import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/controller/AuthController.dart';
import 'package:insta_mvc_demo/utils/DeviceUtils.dart';
import 'package:insta_mvc_demo/view/styles/RegisterScreenStyles.dart';
import 'package:insta_mvc_demo/view/widgets/text_input.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _setPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: _DIMENS.MARGIN_TOP),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: _DIMENS.WHITE_SPACING,
                  ),
                  InkWell(
                    onTap: () => AuthController.launchPicker(context),
                    child: ClipOval(
                      child: Container(
                        height: _DIMENS.PROFILE_IMAGE_HEIGHT,
                        width: _DIMENS.PROFILE_IMAGE_WIDTH,
                        decoration: BoxDecoration(
                          border: Border.all(width: 5.0),
                          // border color
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100.0),
                          ),
                        ),
                        child: AuthController.profileImage.isNotEmpty
                            ? Image.file(
                                File(AuthController.profileImage.string),
                                fit: BoxFit.cover,
                              )
                            : const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "http://i.imgur.com/HQ3YU7n.gif"),
                                radius: 50.0,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: _DIMENS.WHITE_SPACING,
                  ),
                  Container(
                    height: DeviceUtils.fractionHeight(context, fraction: 15.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: _DIMENS.MARGIN_HORIZONTAL),
                    child: TextInputField(
                      controller: _usernameController,
                      myLabelText: "Username",
                      myIcon: Icons.person,
                      toHide: false,
                    ),
                  ),
                  const SizedBox(
                    height: _DIMENS.WHITE_SPACING,
                  ),
                  Container(
                    height: DeviceUtils.fractionHeight(context, fraction: 15.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: _DIMENS.MARGIN_HORIZONTAL),
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
                        horizontal: _DIMENS.MARGIN_HORIZONTAL),
                    child: TextInputField(
                      controller: _setPasswordController,
                      myLabelText: "Password",
                      myIcon: Icons.lock,
                      toHide: true,
                    ),
                  ),
                  const SizedBox(
                    height: _DIMENS.WHITE_SPACING,
                  ),
                  Container(
                    height: DeviceUtils.fractionHeight(context, fraction: 15.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: _DIMENS.MARGIN_HORIZONTAL),
                    child: TextInputField(
                      controller: _confirmPasswordController,
                      myLabelText: "Confirm Password",
                      myIcon: Icons.lock,
                      toHide: true,
                    ),
                  ),
                  const SizedBox(
                    height: _DIMENS.WHITE_SPACING,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    onPressed: () {
                      controller.signUp(
                        _usernameController.text,
                        _emailController.text,
                        _setPasswordController.text,
                        AuthController.profilePic,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Text(
                        "Register",
                        style: RegisterScreenStyles.registerButton,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildDisplay(BuildContext context, RxString image) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: _DIMENS.BIG_SPACING),
        height: _DIMENS.DISPLAY_H,
        child: Image.file(File(image.string)));
  }
}

abstract class _DIMENS {
  static const WHITE_SPACING = 30.0;
  static const MARGIN_HORIZONTAL = 20.0;
  static const MARGIN_TOP = 100.0;
  static const BIG_SPACING = 24.0;
  static const DISPLAY_H = 50.0;
  static const PROFILE_IMAGE_WIDTH = 200.0;
  static const PROFILE_IMAGE_HEIGHT = 200.0;
}

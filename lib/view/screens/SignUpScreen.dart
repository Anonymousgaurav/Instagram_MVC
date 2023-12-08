import 'package:flutter/material.dart';
import 'package:insta_mvc_demo/view/widgets/text_input.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _setPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                onTap: () {},
                child: const Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage("http://i.imgur.com/HQ3YU7n.gif"),
                      radius: 50.0,
                    ),
                    Positioned(
                      right: 4,
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: _DIMENS.WHITE_SPACING,
              ),
              Container(
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
              Container(
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
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: const Text("Register"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

abstract class _DIMENS {
  static const WHITE_SPACING = 30.0;
  static const MARGIN_HORIZONTAL = 20.0;
  static const MARGIN_TOP = 100.0;
}

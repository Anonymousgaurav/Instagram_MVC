import 'package:flutter/material.dart';
import 'package:insta_mvc_demo/view/widgets/text_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              onPressed: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: const Text("Login"),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("New User? Click Here"),
            )
          ],
        ),
      ),
    );
  }
}

abstract class _DIMENS {
  static const WHITE_SPACING = 30.0;
  static const MARGIN_HORIZONTAL = 20.0;
}

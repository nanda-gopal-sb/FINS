import 'package:fins/utils/components.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(children: [
            Flexible(flex: 1, child: Container()),
            InputTextField(
              textEditingController: _emailController,
              hintText: "Enter Your Email",
              labelText: "Email",
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            BigActionButton(
              onClick: () {},
              text: "Reset Password",
            ),
            Flexible(flex: 1, child: Container()),
          ]),
        ),
      ),
    );
  }
}

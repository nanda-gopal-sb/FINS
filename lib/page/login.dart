import 'package:fins/components/input_components.dart';
import 'package:fins/page/forgot_password.dart';
import 'package:fins/page/home.dart';
import 'package:fins/page/signup.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(flex: 1, child: Container()),
              const SizedBox(
                height: 200,
                child: Image(image: AssetImage('assets/images/icon.png')),
              ),
              InputTextField(
                textEditingController: _emailController,
                hintText: "Enter Email",
                labelText: "Email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              InputTextField(
                textEditingController: _passwordController,
                hintText: "Enter Password",
                labelText: "Password",
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(height: 10),
              ClickText(
                text: "Forgot Password",
                onClick: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage(),
                  ),
                ),
              ),
              BIgActionButton(
                text: "Login",
                onClick: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('Dont have an account?'),
                  ),
                  ClickText(
                    text: " Create Account",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(flex: 2, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

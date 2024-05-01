import 'package:fins/components/action_button.dart';
import 'package:fins/components/input_text_field.dart';
import 'package:fins/components/click_text.dart';
import 'package:fins/firebase/auth.dart';
import 'package:fins/page/forgot_password.dart';
import 'package:fins/page/signup.dart';
import 'package:fins/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res != "success") {
      if (context.mounted) showSnackBar(context, res);
    } else {
      if (context.mounted) goToHome(context);
    }
    setState(() {
      _isLoading = false;
    });
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
              ActionButton(ontap: login, isLoading: _isLoading, text: "Login"),
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

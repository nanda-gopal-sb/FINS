import 'package:fins/components/input_components.dart';
import 'package:flutter/material.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.grey.shade800,
                    ),
                    const Text(" Add a Photo"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InputTextField(
                textEditingController: _nameController,
                hintText: "Enter Your Full Name",
                labelText: "Name",
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              InputTextField(
                textEditingController: _emailController,
                hintText: "Enter Your Email",
                labelText: "Email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              InputTextField(
                textEditingController: _passwordController,
                hintText: "Enter A Strong Password",
                labelText: "Password",
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(height: 20),
              BIgActionButton(
                onClick: () {},
                text: "Create Account",
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have account?"),
                  ClickText(
                    text: " Login",
                    onClick: () => Navigator.of(context).pop(),
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

MaterialStatePropertyAll<Color> colorToMColor(Color c) {
  return MaterialStatePropertyAll(c);
}

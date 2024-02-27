import 'package:fins/app_theme.dart';
import 'package:fins/components/input_components.dart';
import 'package:fins/firebase/auth.dart';
import 'package:fins/utils/file_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
  Uint8List? _image;

  final defaultPfP = Image.asset(
    'assets/images/default_pfp.jpg',
    height: 200,
    width: 200,
  );

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getAssetAsUint8List("assets/images/default_pfp.jpg")
        .then((value) => setState(() => _image = value));
  }

  void selectImage() async {
    final ImagePicker imgPicker = ImagePicker();

    XFile? file = await imgPicker.pickImage(source: ImageSource.gallery);
    Uint8List img;
    if (file != null) {
      file.readAsBytes().then((img) => setState(() => _image = img));
    } else {
      print("No img selected");
      img = await getAssetAsUint8List("assets/images/default_pfp.jpg");
      setState(() => _image = img);
    }
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
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: getAppTheme().colorScheme.background,
                      child:
                          _image != null ? Image.memory(_image!) : defaultPfP,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey.shade800,
                          size: 40,
                        ),
                      ),
                    ),
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
                onClick: () async {
                  String res = await AuthMethods().signUpUser(
                    email: _emailController.text,
                    name: _nameController.text,
                    password: _passwordController.text,
                    file: _image!,
                  );
                },
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

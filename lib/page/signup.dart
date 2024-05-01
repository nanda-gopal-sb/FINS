import 'package:fins/components/action_button.dart';
import 'package:fins/components/input_text_field.dart';
import 'package:fins/components/click_text.dart';
import 'package:fins/firebase/auth.dart';
import 'package:fins/utils/file_handler.dart';
import 'package:fins/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  bool _isDefaultPfp = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
    List<String> acceptedPfpExtensions = ["jpg", "jpeg", "png", "jpe"];

    if (file != null) {
      file.readAsBytes().then((img) => setState(() {
            var mime = lookupMimeType('', headerBytes: img);
            String imageExt = mime != null ? extensionFromMime(mime) : "null";
            if (acceptedPfpExtensions.contains(imageExt)) {
              _image = img;
              _isDefaultPfp = false;
            } else {
              showSnackBar(
                context,
                "Select a image in jpg or png format. $imageExt",
              );
            }
          }));
    } else {
      if (_isDefaultPfp && context.mounted) {
        showSnackBar(context, "No image selected");
      }
    }
  }

  void signUp() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
      file: _image!,
      confirmPassword: _confirmPasswordController.text,
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
    var colorScheme = Theme.of(context).colorScheme;
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
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: colorScheme.background,
                        image: DecorationImage(
                          image: fetchImageSafely(_image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(
                          color: colorScheme.onPrimaryContainer,
                          width: 1.0,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(
                          Icons.add_a_photo,
                          color: colorScheme.secondary,
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
              const SizedBox(height: 10),
              InputTextField(
                textEditingController: _confirmPasswordController,
                hintText: "Confirm Password",
                labelText: "Password",
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(height: 20),
              ActionButton(
                ontap: signUp,
                isLoading: _isLoading,
                text: "Create Account",
              ),
              const SizedBox(height: 40),
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

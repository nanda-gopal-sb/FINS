import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

var interpreter;

Future loadModel() async {
  interpreter = await Interpreter.fromAsset('assets/models/output.tflite');
}

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Image? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 20),
          LongButton(
            onclick: () => _pickImage(ImageSource.gallery),
            text: "Upload Image from Gallary",
            bgcolor: Colors.green,
          ),
          const SizedBox(height: 20),
          LongButton(
            onclick: () => _pickImage(ImageSource.camera),
            text: "Upload Image from Camera",
            bgcolor: Colors.blue,
          ),
          const SizedBox(height: 20),
          _selectedImage != null
              ? Image(
                  image: _selectedImage!.image,
                  width: 300,
                  // height: 150,
                )
              : const Text("Please Select an Image"),
        ],
      ),
    );
  }

  Future runModel() async {
    loadModel();
    var output = [];
    interpreter.run(_selectedImage, output);
  }

  Future _pickImage(ImageSource source) async {
    final returnedImage = await ImagePicker().pickImage(source: source);
    if (returnedImage == null) return;
    setState(() {
      if (kIsWeb) {
        _selectedImage = Image.network(returnedImage.path);
      } else {
        _selectedImage = Image.file(File(returnedImage.path));
      }
    });
  }
}

class LongButton extends StatelessWidget {
  final VoidCallback onclick;
  final String text;
  final Color bgcolor;
  const LongButton({
    super.key,
    required this.onclick,
    required this.text,
    required this.bgcolor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onclick,
      color: bgcolor,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

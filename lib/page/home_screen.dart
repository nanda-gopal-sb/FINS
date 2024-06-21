import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Image? _selectedImage;
  Future<void> _loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/models/output.tflite",
        labels: "assets/models/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future<void> _runModel(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      // threshold: 0.05,
      // imageMean: 127.5,
      // imageStd: 127.5,
    );

    print(recognitions);
    print("Called");
  }

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  //  Future<void> initHelper() async {
  //   _loadLabels();
  //   _loadModel();
  //   isolateInference = IsolateInference();
  //   await isolateInference.start();
  // }
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
            bgcolor: Colors.red,
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

  Future _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return;
    final returnedImagePath = pickedFile.path;
    setState(() {
      if (kIsWeb) {
        _selectedImage = Image.network(returnedImagePath);
      } else {
        _selectedImage = Image.file(File(returnedImagePath));
      }
      File image = File(pickedFile.path);
      _runModel(image);
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

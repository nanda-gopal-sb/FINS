import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as im;

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Image? _selectedImage;
  late Tensor inputTensor;
  late Tensor outputTensor;
  var labels;
  //late final IsolateInference isolateInference;
  // ignore: unused_element
  Future<void> _loadAndRun() async {
    final interpreter =
        await Interpreter.fromAsset('assets/models/output.tflite');
    inputTensor = interpreter.getInputTensors().first;
    outputTensor = interpreter.getOutputTensors().first;

    //print("Called");
  }

  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString("assets/models/labels.txt");
    labels = labelTxt.split('\n');
  }

  @override
  void initState() {
    super.initState();
    _loadLabels();
    _loadAndRun();
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

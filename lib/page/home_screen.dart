import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            child: MaterialButton(
              onPressed: () {
                _pickImageFromGallery();
              },
              color: Colors.green,
              child: const Text(
                "Upload Image from Gallary",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: MaterialButton(
              onPressed: () {
                _pickImageFromCamera();
              },
              color: Colors.cyan,
              child: const Text(
                "Upload Image from Camera",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _selectedImage != null
              ? Image.file(
                  _selectedImage!,
                  width: 300,
                  height: 150,
                )
              : const Text("Please Select an Image"),
        ],
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
        if(returnedImage == null) return ; 
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
        if(returnedImage == null) return ; 
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}

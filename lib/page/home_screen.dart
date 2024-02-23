import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: must_be_immutable
class UploadPage extends StatelessWidget{
   UploadPage({super.key});
  File ? _selectedImage ; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
	body : Center(
		child: Column(
			children: [
				MaterialButton(
				onPressed:() {
          _pickImageFromGallery();
        } ,
				color: Colors.green,
				child: const Text("Upload Image from Gallary",
				style: TextStyle(
				color: Colors.white, 
				fontWeight: FontWeight.bold, 
				fontSize: 16
        ),)),
				const SizedBox(height: 20,),
				_selectedImage != null ? Image.file(_selectedImage!) : const Text("Please Select an Image")
			]
		)
	)
);
  }
    Future _pickImageFromGallery() async {
      final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery); 
      setState((){
        _selectedImage = File(returnedImage!.path);
      });
    }
  }
  
  void setState(VoidCallback fn) {
}
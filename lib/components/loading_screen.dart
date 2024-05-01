import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loading sensor data",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(color: Colors.green),
        ],
      ),
    );
  }
}

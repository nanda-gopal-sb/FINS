import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  const InputTextField({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.labelText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        labelText: labelText,
        contentPadding: const EdgeInsets.all(10),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}

class ClickText extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  const ClickText({
    super.key,
    required this.text,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

class BigActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  const BigActionButton({
    super.key,
    required this.text,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton(
        onPressed: onClick,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}

Padding actionButton(
  BuildContext context,
  VoidCallback ontap,
  bool isLoading,
  String text,
) {
  Color onPrimary = Theme.of(context).colorScheme.onPrimary;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Material(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: ontap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SizedBox(
              height: 30,
              child: isLoading
                  ? SizedBox(
                      width: 30,
                      child: CircularProgressIndicator(color: onPrimary),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: onPrimary,
                        fontSize: 22,
                      ),
                    ),
            ),
          ),
        ),
      ),
    ),
  );
}

showSnackBar(BuildContext context, String res) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(res),
    ),
  );
}

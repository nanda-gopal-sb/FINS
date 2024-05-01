import 'package:flutter/material.dart';

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

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.ontap,
    required this.isLoading,
    required this.text,
  });

  final VoidCallback ontap;
  final bool isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
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
}

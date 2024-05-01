import 'package:fins/components/progress_bar.dart';
import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  const SensorCard({
    super.key,
    required this.heading,
    required this.value,
    required this.unit,
  });

  final String heading;
  final String unit;
  final double value;

  @override
  Widget build(BuildContext context) {
    var sensorHeadingStyle = const TextStyle(
      fontSize: 25,
    );
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            // Find a better name for shadow color
            color: Theme.of(context).colorScheme.tertiary.withAlpha(70),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          ),
          BoxShadow(
            // to color inside card
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            heading,
            style: sensorHeadingStyle,
          ),
          ProgressBar(
            value: value,
            unit: unit,
            colorScheme: Theme.of(context).colorScheme,
          ),
        ],
      ),
    );
  }
}

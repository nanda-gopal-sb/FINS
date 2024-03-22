import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SensorWidget extends StatefulWidget {
  const SensorWidget({super.key});

  @override
  State<SensorWidget> createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> {
  double temperature = 0; // to be gotten from Sensors
  double humidity = 0;
  double moisture = 0;
  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    var fa = FirebaseAuth.instance.currentUser!;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref(fa.uid);
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        var snap = event.snapshot;
        temperature = double.parse(snap.child("Temperature").value.toString());
        humidity = double.parse(snap.child("Humidity").value.toString());
        moisture = double.parse(snap.child("Moisture").value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // initDatabase();
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SensorCard(heading: "Temperature", unit: " °C", value: temperature),
            SensorCard(heading: "Humidity", unit: " %", value: humidity),
            SensorCard(heading: "Soil Moisture", unit: " %", value: moisture),
          ],
        ),
      ),
    );
  }
}

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

class ProgressBar extends StatelessWidget {
  const ProgressBar(
      {super.key,
      required double value,
      required ColorScheme colorScheme,
      required String unit})
      : _value = value,
        _colorScheme = colorScheme,
        _unit = unit;
  final sensorValueStyle = const TextStyle(
    fontSize: 25,
  );
  final double _value;
  final ColorScheme _colorScheme;
  final String _unit;
  @override
  Widget build(BuildContext context) {
    final sensorHandleColor = _colorScheme.primary;
    final sensorHandleBGColor = _colorScheme.onPrimaryContainer;
    return SizedBox(
      height: 200,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              cornerStyle: CornerStyle.bothCurve,
              color: sensorHandleBGColor,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: _value,
                cornerStyle: CornerStyle.bothCurve,
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
                color: sensorHandleColor,
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: Text(
                  '${_value.toStringAsFixed(0)}$_unit',
                  style: sensorValueStyle,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

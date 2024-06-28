// ignore: unused_import
import 'package:fins/components/loading_screen.dart';
import 'package:fins/components/sensor_card.dart';
import 'package:fins/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SensorWidget extends StatefulWidget {
  const SensorWidget({super.key});
  @override
  State<SensorWidget> createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> {
  double temperature = 0; // to be gotten from Sensors
  double humidity = 0;
  double moisture = 0;
  double rain = 0;
  bool isLoading = true;
  bool isConnected = true;
  FirebaseDatabase database = FirebaseDatabase.instance;
  @override
  void initState() {
    super.initState();
    var fa = FirebaseAuth.instance.currentUser!;
    DatabaseReference userSensorDataRef = FirebaseDatabase.instance.ref(fa.uid);
    userSensorDataRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        isLoading = false;
        DataSnapshot snap = event.snapshot;
        // ignore: unused_local_variable
        var data = parseData(bool, snap, "connected");
        if (isConnected) {
          temperature =
              double.parse(snap.child("Temperature").value.toString());
          humidity = double.parse(snap.child("Humidity").value.toString());
          moisture = double.parse(snap.child("Moisture").value.toString());
          rain = double.parse(snap.child("Rain").value.toString());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SensorList(
            temperature: temperature,
            humidity: humidity,
            moisture: moisture,
            rain: rain));
  }
}

// ignore: non_constant_identifier_names
String GetMoistureResult(double val) {
  if (val == 0) {
    return "Water is sufficient";
  } else {
    return "Water is not sufficient";
  }
}

// ignore: non_constant_identifier_names
String GetRainResult(double val) {
  if (val == 0) {
    return "Rain is sufficient";
  } else {
    return "Rain is not sufficient";
  }
}

class SensorList extends StatelessWidget {
  const SensorList(
      {super.key,
      required this.temperature,
      required this.humidity,
      required this.moisture,
      required this.rain});

  final double temperature;
  final double humidity;
  final double moisture;
  final double rain;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SensorCard(heading: "Temperature", unit: " °C", value: temperature),
          SensorCard(heading: "Humidity", unit: " %", value: humidity),
          ShowText(text: GetMoistureResult(moisture)),
          ShowText(text: GetRainResult(rain)),
          //SensorCard(heading: "Soil Moisture", unit: " %", value: moisture),
        ],
      ),
    );
  }
}

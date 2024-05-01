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
  bool isLoading = true;
  bool isConnected = false;
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
        var data = parseData(bool, snap, "connected");
        isConnected = data == 0 ? false : data;
        print(isConnected);
        if (isConnected) {
          temperature =
              double.parse(snap.child("Temperature").value.toString());
          humidity = double.parse(snap.child("Humidity").value.toString());
          moisture = double.parse(snap.child("Moisture").value.toString());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
          ? const LoadingScreen()
          : isConnected
              ? SensorList(
                  temperature: temperature,
                  humidity: humidity,
                  moisture: moisture,
                )
              : const Center(
                  child: Text("No sensors are connected"),
                ),
    );
  }
}

class SensorList extends StatelessWidget {
  const SensorList({
    super.key,
    required this.temperature,
    required this.humidity,
    required this.moisture,
  });

  final double temperature;
  final double humidity;
  final double moisture;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SensorCard(heading: "Temperature", unit: " °C", value: temperature),
          SensorCard(heading: "Humidity", unit: " %", value: humidity),
          SensorCard(heading: "Soil Moisture", unit: " %", value: moisture),
        ],
      ),
    );
  }
}

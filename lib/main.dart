import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const FINS());
}

class FINS extends StatelessWidget {
  const FINS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FINS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.greenAccent,
          background: Colors.white,
          onBackground: Colors.greenAccent,
          secondary: Colors.green,
          primaryContainer: Colors.green.shade50,
          onPrimaryContainer: Colors.green.shade100,
        ),
        useMaterial3: true,
      ),
      home: const App(title: 'FINS Home'),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key, required this.title});
  final String title;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedPageIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> pages = <Widget>[
      SensorWidget(),
      Placeholder(),
      Placeholder(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors_sharp),
            label: 'Sensors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
        currentIndex: _selectedPageIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}

class SensorWidget extends StatelessWidget {
  const SensorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double temperature = 39;
    double moisture = 25;
    double humidity = 85;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SensorCard(heading: "Temperature", unit: " °C", value: temperature),
            SensorCard(heading: "Humidity", unit: " %", value: humidity),
            SensorCard(heading: "Moisture", unit: " %", value: moisture),
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
        boxShadow: const [
          BoxShadow(
            color: Color(0xffDDDDDD),
            blurRadius: 14.0,
            spreadRadius: 1.0,
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.primaryContainer,
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

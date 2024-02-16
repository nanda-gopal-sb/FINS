import 'package:flutter/material.dart';
//import 'package:flutter_login/flutter_login.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
//import 'package:flutter_login/theme.dart';
void main() {
  //MaterialApp(home: MyHome()),
  runApp(const MaterialApp(home: Login()),);
}
const users =  {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    const Directionality(
          textDirection: TextDirection.ltr,
          child: Text('Hello'));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/flutter-logo.png')),
              ),
            ),
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: (){
                // FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const FINS()));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            const Text('New User? Create Account')
          ],
        ),
      ),
    );
  }
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
      home: const HomePage(title: 'FINS Home'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Row(children: [pages[_selectedPageIndex]]),
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
    double temperature = 39; //to be gotten from Sensors
    double moisture = 25;
    double humidity = 85;
    double soilMosture = 55; 
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SensorCard(heading: "Temperature", unit: " °C", value: temperature),
            SensorCard(heading: "Humidity", unit: " %", value: humidity),
            SensorCard(heading: "Moisture", unit: " %", value: moisture),
            SensorCard(heading: "SoilMosture", unit: " %", value: soilMosture),
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
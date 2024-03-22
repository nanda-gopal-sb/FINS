//import 'package:camera/camera.dart';
import 'package:fins/page/home_screen.dart';
import 'package:fins/page/sensors_screen.dart';
import 'package:fins/page/user_page.dart';
import 'package:fins/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      const SensorWidget(),
      const UploadPage(),
      const UserPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("FINS App"),
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

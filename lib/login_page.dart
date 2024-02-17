import 'package:fins/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> asyncSetLoginStateTrue(
    BuildContext context,
    VoidCallback callback,
  ) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setBool("isLoggedIn", true);
    callback.call();
  }

  @override
  Widget build(BuildContext context) {
    const Directionality(
      textDirection: TextDirection.ltr,
      child: Text('Hello'),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: SizedBox(
              height: 200,
              child: Image(image: AssetImage('assets/images/icon.png')),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter valid email id as abc@gmail.com',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 15,
              bottom: 15,
            ),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter secure password',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // FORGOT PASSWORD SCREEN GOES HERE
            },
            style: Theme.of(context).textButtonTheme.style!.copyWith(
                  backgroundColor:
                      colorToMColor(Theme.of(context).colorScheme.background),
                ),
            child: const Text(
              'Forgot Password',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () async {
                _LoginPageState().asyncSetLoginStateTrue(context, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                });
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text('New User? Create Account')
        ],
      ),
    );
  }
}

MaterialStatePropertyAll<Color> colorToMColor(Color c) {
  return MaterialStatePropertyAll(c);
}

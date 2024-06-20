import 'package:fins/components/action_button.dart';
import 'package:fins/firebase/auth.dart';
import 'package:fins/models/user.dart';
import 'package:fins/page/login.dart';
import 'package:fins/provider/user_provider.dart';
import 'package:fins/utils/file_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [UserProfile()],
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserProvider>(context).getUser;
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            image: DecorationImage(
              image: fetchImageSafely(user.photoURL),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
            border: Border.all(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              width: 1.0,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          user.name,
          style: const TextStyle(fontSize: 30),
        ),
        Text(
          user.email,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 30,
        ),
        BigActionButton(
          text: "Log Out",
          onClick: () {
            AuthMethods().signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
        )
      ],
    );
  }
}

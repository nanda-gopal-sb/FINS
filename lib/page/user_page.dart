import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
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

  Future<String?> getUserParams() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    String? userName = spref.getString("userName");
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Icon(
            Icons.account_circle_sharp,
            size: 200,
            color: Colors.black.withOpacity(.6),
          ),
        ),
        // Text(usrn, style: userPageNameTextTheme),
      ],
    );
  }
}

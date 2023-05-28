import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class LoginModule {
  passpage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ), (route) {
      return false;
    });
  }
}

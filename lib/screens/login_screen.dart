import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/screens/signup_screen.dart';

import '../models/error_model.dart';
import '../models/token_model.dart';
import '../modules/preferences.dart';
import 'home_screen.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
const String baseUrl = "http://54.180.121.245:3000";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Preferences pref = Preferences();

  passpage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ), (route) {
      return false;
    });
  }

  snackbar(errorMes) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(errorMes),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future login() async {
    final url = Uri.parse('$baseUrl/auth');

    final response = await http.post(
      url,
      body: {
        'email': email.text,
        'password': password.text,
      },
    );

    if (response.statusCode == 201) {
      final accessToken = jsonDecode(response.body);
      final realToken = TokenModel.fromjson(accessToken).token;
      passpage();

      if (accessToken != null) {
        pref.saveTokenToStorage(realToken);
      }
    } else {
      final errorMessage = jsonDecode(response.body);
      final realErrorMessage = ErrorModel.fromjson(errorMessage).message;
      realErrorMessage;
      snackbar(realErrorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        title: const Text(
          "Todos",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "E-mail",
                hintText: "E-mail",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: "password",
                hintText: "password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                login();
                email.text = "";
                password.text = "";
              },
              child: const Text(
                "Login",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "don't have ID?",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.grey),
                ),
                const SizedBox(
                  width: 20,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                        (route) {
                          return false;
                        },
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/error_model.dart';
import 'login_screen.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController name = TextEditingController();
const String baseUrl = "http://54.180.121.245:3000";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future signup() async {
    final url = Uri.parse('$baseUrl/users');
    final response = await http.post(
      url,
      body: {
        'email': email.text,
        'password': password.text,
        'name': name.text,
      },
    );

    if (response.statusCode == 201) {
      passpage();
    } else {
      final errorMessage = jsonDecode(response.body);
      final realErrorMessage = ErrorModel.fromjson(errorMessage).message;
      realErrorMessage;
      snackbar(realErrorMessage);
    }
  }

  passpage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
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
      body: Form(
        child: Container(
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
                height: 10,
              ),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: "name",
                  hintText: "name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  signup();
                  email.text = "";
                  password.text = "";
                  name.text = "";
                },
                child: const Text(
                  "SignUp",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

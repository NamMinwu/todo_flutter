import 'package:flutter/material.dart';
import 'package:todolist/services/api_service.dart';

import '../models/profile.dart';

class PrivatePage extends StatelessWidget {
  PrivatePage({super.key});
  final Future<ProfileModel> profile = ApiService.getProfile();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
          future: profile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(snapshot.data!.name),
                  const SizedBox(height: 30),
                  Column(
                    children:
                        snapshot.data!.todos.map((e) => Text(e.title)).toList(),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}

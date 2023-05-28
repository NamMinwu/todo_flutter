import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/profile.dart';
import '../modules/preferences.dart';

class ApiService {
  static Preferences pref = Preferences();
  static const String baseUrl = "http://54.180.121.245:3000";
  final token = pref.getTokenFromStorage();

  static Future<ProfileModel> getProfile() async {
    // final todoList = [];
    final url = Uri.parse('$baseUrl/auth/profile');
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${await pref.getTokenFromStorage()}'
    });
    if (response.statusCode == 200) {
      final profile = jsonDecode(response.body);
      final todos = ProfileModel.fromJson(profile);
      return todos;
    }
    throw Error();
  }
}

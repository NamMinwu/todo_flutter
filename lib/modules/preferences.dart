import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late String accessToken;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Preferences();

  getTokenFromStorage() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('accessToken');
    if (token != null) {
      accessToken = token;
      return token;
    }
    return null;
  }

  removeTokenFromStorage() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('accessToken');
  }

  saveTokenToStorage(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('accessToken', token);
  }
}

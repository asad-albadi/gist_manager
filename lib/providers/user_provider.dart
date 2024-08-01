// user_provider.dart

import 'package:_mobile_app_to_lookup_and_search_gists/models/user_model.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String _errorMessage = '';

  User? get user => _user;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUserProfile() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? token = prefs.getString('token');

    if (username != null && token != null) {
      try {
        _user = await ApiService().fetchUserProfile(username, token);
      } catch (e) {
        _errorMessage = e.toString();
      }
    } else {
      _errorMessage = 'Username or token is missing';
    }

    _isLoading = false;
    notifyListeners();
  }

  void saveCredentials(String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('token', token);
    fetchUserProfile(); // Fetch user profile after saving credentials
  }
}

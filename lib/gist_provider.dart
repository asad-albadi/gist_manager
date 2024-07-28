import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'models/gist_model.dart';

class GistProvider with ChangeNotifier {
  List<Gist> _gists = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Gist> get gists => _gists;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchGists() async {
    print('fetchGists called');
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? token = prefs.getString('token');

    print('Username: $username, Token: $token');

    if (username != null && token != null) {
      try {
        List<Gist> fetchedGists =
            await ApiService().fetchGists(username, token);
        _gists = await Future.wait(fetchedGists.map((gist) async {
          String content =
              await ApiService().fetchGistContent(username, token, gist.id);
          return Gist(
            id: gist.id,
            filename: gist.filename,
            description: gist.description,
            content: content,
            createdAt: gist.createdAt,
          );
        }));
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
    print('Credentials saved: $username, $token');
  }
}

// gist_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../models/gist_model.dart';

class GistProvider with ChangeNotifier {
  List<Gist> _gists = [];
  List<Gist> _filteredGists = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Gist> get gists => _filteredGists;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchGists() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? token = prefs.getString('token');

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
            url: gist.url,
          );
        }));
        _filteredGists = _gists;
      } catch (e) {
        _errorMessage = e.toString();
      }
    } else {
      _errorMessage = 'Username or token is missing';
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchGists(String query) {
    final lowerCaseQuery = query.toLowerCase();
    _filteredGists = _gists
        .where((gist) =>
            gist.filename.toLowerCase().contains(lowerCaseQuery) ||
            (gist.description?.toLowerCase().contains(lowerCaseQuery) ??
                false) ||
            gist.content.toLowerCase().contains(lowerCaseQuery))
        .toList();
    notifyListeners();
  }

  void sortGistsByFilename(bool ascending) {
    _filteredGists.sort((a, b) => ascending
        ? a.filename.compareTo(b.filename)
        : b.filename.compareTo(a.filename));
    notifyListeners();
  }

  void sortGistsByDate(bool ascending) {
    _filteredGists.sort((a, b) => ascending
        ? a.createdAt.compareTo(b.createdAt)
        : b.createdAt.compareTo(a.createdAt));
    notifyListeners();
  }

  Future<void> saveCredentials(String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('token', token);
  }
}

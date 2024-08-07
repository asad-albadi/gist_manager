// gist_provider.dart

import 'package:flutter/material.dart';
import 'package:gist_manager/models/gist_model.dart';
import 'package:gist_manager/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            await ApiService().fetchAllGists(username, token);
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
            isPublic: gist.isPublic,
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

  Future<void> deleteGist(String gistId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? token = prefs.getString('token');

    if (username != null && token != null) {
      try {
        await ApiService().deleteGist(username, token, gistId);
        _gists.removeWhere((gist) => gist.id == gistId);
        _filteredGists.removeWhere((gist) => gist.id == gistId);
        notifyListeners();
      } catch (e) {
        _errorMessage = e.toString();
        notifyListeners();
      }
    } else {
      throw Exception('Username or token is missing');
    }
  }

  Future<void> createGist(String filename, String description, String content,
      bool isPublic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? token = prefs.getString('token');

    if (username != null && token != null) {
      try {
        Gist newGist = await ApiService().createGist(
            username, token, filename, description, content, isPublic);

        // Check for duplicates before adding
        if (!_gists.any((gist) => gist.id == newGist.id)) {
          _gists.insert(0, newGist);
          //_filteredGists.insert(0, newGist);
          notifyListeners();
        }
      } catch (e) {
        _errorMessage = e.toString();
        notifyListeners();
      }
    } else {
      throw Exception('Username or token is missing');
    }
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

  void filterGists(String filter) {
    if (filter == 'All') {
      _filteredGists = _gists;
    } else if (filter == 'Public') {
      _filteredGists = _gists.where((gist) => gist.isPublic).toList();
    } else if (filter == 'Secret') {
      _filteredGists = _gists.where((gist) => !gist.isPublic).toList();
    }
    notifyListeners();
  }

  Future<void> saveCredentials(String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('token', token);
  }

  Future<void> editGist(String gistId, String filename, String description,
      String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? token = prefs.getString('token');

    if (username != null && token != null) {
      await ApiService()
          .editGist(username, token, gistId, filename, description, content);

      // Find the index of the edited gist
      int index = _gists.indexWhere((gist) => gist.id == gistId);

      // Update the gist in the list
      if (index != -1) {
        _gists[index] = Gist(
          id: gistId,
          filename: filename,
          description: description,
          content: content,
          createdAt: _gists[index].createdAt,
          url: _gists[index].url,
          isPublic: _gists[index].isPublic,
        );
        _filteredGists = _gists;
      }

      notifyListeners();
    } else {
      throw Exception('Username or token is missing');
    }
  }
}

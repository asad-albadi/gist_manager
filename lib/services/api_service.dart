// api_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/gist_model.dart';
import '../models/user_model.dart'; // Import the user model

class ApiService {
  final String baseUrl = "https://api.github.com";

  Future<List<Gist>> fetchGists(String username, String token,
      {int page = 1, int perPage = 30}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$username/gists?page=$page&per_page=$perPage'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((gist) => Gist.fromJson(gist)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Failed to load gists, Bad credentials');
    } else {
      throw Exception('Failed to load gists');
    }
  }

  Future<void> editGist(String username, String token, String gistId,
      String filename, String content) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/gists/$gistId'),
      headers: {
        'Authorization': 'token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'files': {
          filename: {
            'content': content,
          },
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit gist');
    }
  }

  Future<List<Gist>> fetchAllGists(String username, String token) async {
    int page = 1;
    int perPage = 30;
    List<Gist> allGists = [];

    while (true) {
      List<Gist> gists =
          await fetchGists(username, token, page: page, perPage: perPage);
      if (gists.isEmpty) {
        break;
      }
      allGists.addAll(gists);
      page++;
    }

    return allGists;
  }

  Future<User> fetchUserProfile(String username, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$username'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception('Failed to load user profile, Bad credentials');
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<String> fetchGistContent(
      String username, String token, String gistId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/gists/$gistId'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['files'].values.first['content'];
    } else {
      throw Exception('Failed to load gist content');
    }
  }
}

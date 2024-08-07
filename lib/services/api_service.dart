import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/gist_model.dart';
import '../models/user_model.dart';

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
      List<Gist> gists = await Future.wait(data.map((gistJson) async {
        bool isStarred = await isGistStarred(token, gistJson['id']);
        return Gist.fromJson(gistJson, isStarred);
      }).toList());
      return gists;
    } else if (response.statusCode == 401) {
      throw Exception('Failed to load gists, Bad credentials');
    } else {
      throw Exception('Failed to load gists');
    }
  }

  Future<bool> isGistStarred(String token, String gistId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/gists/$gistId/star'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    return response.statusCode == 204;
  }

  Future<void> starGist(String token, String gistId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/gists/$gistId/star'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to star gist');
    }
  }

  Future<void> unstarGist(String token, String gistId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/gists/$gistId/star'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to unstar gist');
    }
  }

  Future<Gist> createGist(String username, String token, String filename,
      String description, String content, bool isPublic) async {
    final response = await http.post(
      Uri.parse('$baseUrl/gists'),
      headers: {
        'Authorization': 'token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'description': description,
        'public': isPublic,
        'files': {
          filename: {
            'content': content,
          },
        },
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Gist.fromJson(data, false); // New gist is not starred by default
    } else {
      throw Exception('Failed to create gist');
    }
  }

  Future<void> editGist(String username, String token, String gistId,
      String filename, String description, String content) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/gists/$gistId'),
      headers: {
        'Authorization': 'token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'description': description,
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

  Future<void> toggleGistVisibility(
      String username, String token, Gist gist) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/gists/${gist.id}'),
      headers: {
        'Authorization': 'token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'description': gist.description,
        'public': !gist.isPublic,
        'files': {
          gist.filename: {
            'content': gist.content,
          },
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle gist visibility');
    }
  }

  Future<void> deleteGist(String username, String token, String gistId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/gists/$gistId'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete gist');
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

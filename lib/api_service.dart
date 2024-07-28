import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/gist_model.dart';

class ApiService {
  final String baseUrl = "https://api.github.com";

  Future<List<Gist>> fetchGists(String username, String token) async {
    print('Fetching gists for user: $username');
    final response = await http.get(
      Uri.parse('$baseUrl/users/$username/gists'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((gist) => Gist.fromJson(gist)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Failed to load gists, Bad credentials');
    } else {
      throw Exception('Failed to load gists');
    }
  }

  Future<String> fetchGistContent(
      String username, String token, String gistId) async {
    print('Fetching gist content for gist ID: $gistId');
    final response = await http.get(
      Uri.parse('$baseUrl/gists/$gistId'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    print('Content Response status: ${response.statusCode}');
    print('Content Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['files'].values.first['content'];
    } else {
      throw Exception('Failed to load gist content');
    }
  }
}

// user_model.dart

class User {
  final String login;
  final String avatarUrl;
  final String htmlUrl;

  User({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
    );
  }
}

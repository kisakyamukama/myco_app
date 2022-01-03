class User {
  String id;
  String username;
  String email;
  List<String> roles;
  String accessToken;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.roles,
      required this.accessToken});

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> _roles = [];
    if (json['roles'] != null) {
      json['roles'].forEach((v) {
        _roles.add(v);
      });
    }
    return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        roles: _roles,
        accessToken: json['accessToken']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    // if (this.roles != null) {
    //   data['roles'] = this.roles.map((v) => v.toJson()).toList();
    // }
    data['accessToken'] = this.accessToken;
    return data;
  }
}

class Client {
  int? id;
  String? username;
  String? phone_number;
  String? password;
  String? token;

  Client({
    this.id,
    this.username,
    this.phone_number,
    this.password,
    this.token,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      username: json['username'],
      phone_number: json['phone_number'],
      password: json['password'],
      token: json['token'],
    );
  }
}

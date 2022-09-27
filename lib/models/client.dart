class Client {
  int? id;
  String? username;
  String? phone_number;
  String? full_name;
  String? whatsapp_number;
  String? token;

  Client({
    this.id,
    this.username,
    this.phone_number,
    this.full_name,
    this.whatsapp_number,
    this.token,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['client']['id'],
      username: json['client']['username'],
      phone_number: json['client']['phone_number'],
      full_name: json['client']['full_name'],
      whatsapp_number: json['client']['whatsapp_number'],
      token: json['token'],
    );
  }
}

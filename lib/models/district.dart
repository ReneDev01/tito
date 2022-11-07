class District {
  int? id;
  String? name;
  String? geopoint;
  int? state;
  String? diameter;

  District({this.id, this.name, this.geopoint, this.state, this.diameter});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    geopoint = json['geopoint'];
    state = json['state'];
    diameter = json['diameter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['geopoint'] = this.geopoint;
    data['state'] = this.state;
    data['diameter'] = this.diameter;
    return data;
  }
}

class Trip {
  int? id;
  String? phone_number;
  Map? start_location;
  String? start_description;
  Map? end_location;
  String? end_description;
  String? startLat;
  String? startLng;
  String? endLat;
  String? endLng;

  Trip({
    this.id,
    this.phone_number,
    this.start_location,
    this.start_description,
    this.end_location,
    this.end_description,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
  });

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone_number = json['phone_number'];
    start_location = {"lat": startLat, "lng": startLng};
    start_description = json['start_description'];
    end_location = {"lat": endLat, "lng": endLng};
    end_description = json['end_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_number'] = this.phone_number;
    data['start_location'] = this.start_location;
    data['start_description'] = this.start_description;
    data['end_location'] = this.end_location;
    data['end_description'] = this.end_description;
    return data;
  }
}

class start_location {
  String? lat;
  String? lng;

  start_location({this.lat, this.lng});

  start_location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class end_location {
  String? lat;
  String? lng;

  end_location({this.lat, this.lng});

  end_location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

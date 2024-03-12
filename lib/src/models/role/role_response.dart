

class RoleResponse {
  List<Data> data;
  String message;
  bool success;

  RoleResponse({this.data, this.message, this.success});

  RoleResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String adminId;
  String name;
  String phone;
  String address;
  String email;
  String role;
  String zoneId;

  Data(
      {this.adminId,
        this.name,
        this.phone,
        this.address,
        this.email,
        this.role,
        this.zoneId});

  Data.fromJson(Map<String, dynamic> json) {
    adminId = json['admin_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    role = json['role'];
    zoneId = json['zone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_id'] = this.adminId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['email'] = this.email;
    data['role'] = this.role;
    data['zone_id'] = this.zoneId;
    return data;
  }
}



class RoleRegisterModel {
  String name;
  String email;
  String password;
  String address;
  String phone;
  String zoneId;

  RoleRegisterModel(
      {this.name, this.email, this.password, this.address, this.phone,this.zoneId});

  RoleRegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
    phone = json['phone'];
    zoneId = json['zoneId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['zoneId'] = this.zoneId;
    return data;
  }
}

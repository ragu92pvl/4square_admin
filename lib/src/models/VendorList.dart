class ShopList {
  List<TranscationData> transcationData;
  String message;
  bool success;

  ShopList({this.transcationData, this.message, this.success});

  ShopList.fromJson(Map<String, dynamic> json) {
    if (json['transcationData'] != null) {
      transcationData = <TranscationData>[];
      json['transcationData'].forEach((v) {
        transcationData.add(new TranscationData.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transcationData != null) {
      data['transcationData'] =
          this.transcationData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class TranscationData {
  String id;
  String name;
  String displayName;
  String status;
  String address1;

  TranscationData(
      {this.id, this.name, this.displayName, this.status, this.address1});

  TranscationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    status = json['status'];
    address1 = json['address1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['status'] = this.status;
    data['address1'] = this.address1;
    return data;
  }
}
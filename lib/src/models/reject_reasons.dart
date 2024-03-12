


class RejectReasons{
  String reason;
  String createdAt;
  String name;
  String phone;

  RejectReasons();

  RejectReasons.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      reason = jsonMap['reason'] != null ? jsonMap['reason'] : '';
      createdAt = jsonMap['created_at'] != null ? jsonMap['created_at'] : '';
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      phone = jsonMap['phone'] != null ? jsonMap['phone'] : '';
    }catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["reason"] = reason;
    map["created_at"] = createdAt;
    map["name"] = name;
    map["phone"] = phone;
  }
}
class DeliverySettingsModel{
  double radius =0;
  double driverRadius =0;
  bool autoassing;
  bool deliveryTips;
  bool instantDelivery;
  String deliverType;







  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DeliverySettingsModel();

  DeliverySettingsModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      radius = jsonMap['radius'].toDouble() != 0 ? jsonMap['radius'] : 0.0;
      driverRadius = jsonMap['driverRadius'].toDouble() != 0 ? jsonMap['driverRadius'] : 0.0;
      autoassing = jsonMap['autoassing'] != null ? jsonMap['autoassing'] : false;
      deliveryTips = jsonMap['deliveryTips'] != null ? jsonMap['deliveryTips'] : false;
      instantDelivery = jsonMap['instantDelivery'] != null ? jsonMap['instantDelivery'] : false;
      deliverType = jsonMap['deliverType'] != null ? jsonMap['deliverType'] : false;


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["radius"] = radius;
    map["driverRadius"] = driverRadius;
    map["autoassing"] = autoassing;
    map["deliveryTips"] = deliveryTips;
    map["instantDelivery"] = instantDelivery;
    map["deliverType"] = deliverType;








    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
class PaymentGatewayModel{
  String rayzorPaySK;
  String upiId;
  String paypalClientID;
  String fwpbfPublickey;
  String stripePK;
  String stripeSK;
  bool rayzorPay;
  bool upiID;
  bool paypal;
  bool flutterWay;
  bool stripe;


  PaymentGatewayModel();

  PaymentGatewayModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      rayzorPaySK = jsonMap['rayzorPaySK'] != null ? jsonMap['rayzorPaySK'] : '';
      upiId = jsonMap['upiId'] != null ? jsonMap['upiId'] : '';
      paypalClientID = jsonMap['paypalClientID'] != null ? jsonMap['paypalClientID'] : '';
      fwpbfPublickey = jsonMap['fwpbfPublickey'] != null ? jsonMap['fwpbfPublickey'] : '';
      stripePK = jsonMap['stripePK'] != null ? jsonMap['stripePK'] : '';
      stripeSK = jsonMap['stripeSK'] != null ? jsonMap['stripeSK'] : '';
      rayzorPay = jsonMap['rayzorPay'] != null ? jsonMap['rayzorPay'] : false;
      upiID = jsonMap['upiID'] != null ? jsonMap['upiID'] : false;
      paypal = jsonMap['paypal'] != null ? jsonMap['paypal'] : false;
      flutterWay = jsonMap['flutterWay'] != null ? jsonMap['flutterWay'] : false;
      stripe = jsonMap['stripe'] != null ? jsonMap['stripe'] : false;

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rayzorPaySK"] = rayzorPaySK;
    map["upiId"] = upiId;
    map["paypalClientID"] = paypalClientID;
    map["fwpbfPublickey"] = fwpbfPublickey;
    map["stripePK"] = stripePK;
    map["stripeSK"] = stripeSK;
    map["rayzorPay"] = rayzorPay;
    map["upiID"] = upiID;
    map["paypal"] = paypal;
    map["flutterWay"] = flutterWay;
    map["stripe"] = stripe;






    return map;
  }



}
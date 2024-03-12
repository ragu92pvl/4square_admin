class TotalPaymentReport {


  List<TranscationData> transcationData;
  String message;
  bool success;

  TotalPaymentReport({this.transcationData, this.message, this.success});

  TotalPaymentReport.fromJson(Map<String, dynamic> json) {
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
  String shopName;
  String orderAmount;
  String commission;
  String settleMentValue;
  String driverFees;

  TranscationData(
      {this.id,
        this.shopName,
        this.orderAmount,
        this.commission,
        this.settleMentValue,
        this.driverFees});

  TranscationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['ShopName'];
    orderAmount = json['OrderAmount'];
    commission = json['Commission'];
    settleMentValue = json['SettleMentValue'];
    driverFees = json['driver_fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ShopName'] = this.shopName;
    data['OrderAmount'] = this.orderAmount;
    data['Commission'] = this.commission;
    data['SettleMentValue'] = this.settleMentValue;
    data['driver_fees'] = this.driverFees;
    return data;
  }
}
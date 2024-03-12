class DriverPendingAmountModel {
  List<PaymentHistory> paymentHistory;
  String message;
  bool success;

  DriverPendingAmountModel({this.paymentHistory, this.message, this.success});

  DriverPendingAmountModel.fromJson(Map<String, dynamic> json) {
    if (json['paymentHistory'] != null) {
      paymentHistory = new List<PaymentHistory>();
      json['paymentHistory'].forEach((v) {
        paymentHistory.add(new PaymentHistory.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentHistory != null) {
      data['paymentHistory'] =
          this.paymentHistory.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class PaymentHistory {
  int id;
  String orderId;
  String orderDate;
  String settlementAmount;
  String driverTips;
  int total;

  PaymentHistory(
      {this.id,
        this.orderId,
        this.orderDate,
        this.settlementAmount,
        this.driverTips,
        this.total});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    orderDate = json['orderDate'];
    settlementAmount = json['settlementAmount'];
    driverTips = json['driverTips'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['orderDate'] = this.orderDate;
    data['settlementAmount'] = this.settlementAmount;
    data['driverTips'] = this.driverTips;
    data['total'] = this.total;
    return data;
  }
}

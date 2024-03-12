class GetPackages {
  Data data;
  String message;
  bool success;

  GetPackages({this.data, this.message, this.success});

  GetPackages.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String userId;
  String amount;
  String startDate;
  String endDate;
  String days;
  String status;

  Data(
      {this.userId,
        this.amount,
        this.startDate,
        this.endDate,
        this.days,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_Id'];
    amount = json['amount'];
    startDate = json['start_Date'];
    endDate = json['end_Date'];
    days = json['days'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_Id'] = this.userId;
    data['amount'] = this.amount;
    data['start_Date'] = this.startDate;
    data['end_Date'] = this.endDate;
    data['days'] = this.days;
    data['status'] = this.status;
    return data;
  }
}
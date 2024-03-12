import 'dart:core';

// class VendorRequestList {
//   bool success;
//   List<Requestdata> requestdata;
//   String message;
//
//   VendorRequestList({this.success, this.requestdata, this.message});
//
//   VendorRequestList.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['requestdata'] != null) {
//       requestdata = <Requestdata>[];
//       json['requestdata'].forEach((v) {
//         requestdata.add(new Requestdata.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.requestdata != null) {
//       data['requestdata'] = this.requestdata.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }

// class Requestdata {
//   String id;
//   String vendorId;
//   String shopName;
//   String mobile;
//   String amount;
//   String 4squareId;
//   String paymentStatus;
//   String createdAt;
//   String status;
//
//   Requestdata(
//       {this.id,
//       this.vendorId,
//       this.shopName,
//       this.mobile,
//       this.amount,
//       this.4squareId,
//       this.paymentStatus,
//       this.createdAt,
//       this.status});
//
//   Requestdata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorId = json['vendor_id'];
//     shopName = json['shop_name'];
//     mobile = json['mobile'];
//     amount = json['amount'];
//     4squareId = json['4square_id'];
//     paymentStatus = json['payment_status'];
//     createdAt = json['created_at'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['vendor_id'] = this.vendorId;
//     data['shop_name'] = this.shopName;
//     data['mobile'] = this.mobile;
//     data['amount'] = this.amount;
//     data['4square_id'] = this.4squareId;
//     data['payment_status'] = this.paymentStatus;
//     data['created_at'] = this.createdAt;
//     data['status'] = this.status;
//     return data;
//   }
// }

import 'dart:core';

class OtherServiceRequestList {
  List<Addservicedata> addservicedata;
  String message;
  bool success;

  OtherServiceRequestList({this.addservicedata, this.message, this.success});

  OtherServiceRequestList.fromJson(Map<String, dynamic> json) {
    if (json['addservicedata'] != null) {
      addservicedata = <Addservicedata>[];
      json['addservicedata'].forEach((v) {
        addservicedata.add(new Addservicedata.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addservicedata != null) {
      data['addservicedata'] =
          this.addservicedata.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Addservicedata {
  String id;
  String fromname;
  String fphoneno;
  String fromtime;
  String fromlocation;
  String toname;
  String tophoneno;
  String tolocation;
  String description;
  String status;
  String distance1;
  String deliveryfees;
  Addservicedata({
    this.id,
    this.fromname,
    this.fphoneno,
    this.fromtime,
    this.fromlocation,
    this.toname,
    this.tophoneno,
    this.tolocation,
    this.description,
    this.status,
    this.distance1,
    this.deliveryfees,
  });

  Addservicedata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromname = json['fromname'];
    fphoneno = json['fphoneno'];
    fromtime = json['fromtime'];
    fromlocation = json['fromlocation'];
    toname = json['toname'];
    tophoneno = json['tophoneno'];
    tolocation = json['tolocation'];
    description = json['description'];
    status = json['status'];
    distance1 = json['distance1'];
    deliveryfees = json['deliveryfees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromname'] = this.fromname;
    data['fphoneno'] = this.fphoneno;
    data['fromtime'] = this.fromtime;
    data['fromlocation'] = this.fromlocation;
    data['toname'] = this.toname;
    data['tophoneno'] = this.tophoneno;
    data['tolocation'] = this.tolocation;
    data['description'] = this.description;
    data['status'] = this.status;
    data['distance1'] = this.distance1;
    data['deliveryfees'] = this.deliveryfees;

    return data;
  }
}

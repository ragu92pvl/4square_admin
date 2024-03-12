class VendorPlanHistory{
  String id;
  String planId;
  String vendorId;
  String planAmount;
  String createdDate;
  String expireDate;
  String planName;
  String shopName;
  String status;
  String name;
  String phone;

  VendorPlanHistory();
  VendorPlanHistory.fromJSON(Map<String,dynamic> jsonMap){
    try{
      id=jsonMap['id'];
      planId=jsonMap['planId'];
      vendorId=jsonMap['vendorId'];
      planAmount=jsonMap['planAmount'];
      createdDate=jsonMap['createdDate'];
      expireDate=jsonMap['expireDate'];
      planName=jsonMap['planName'];
      shopName=jsonMap['shopName'];
      status=jsonMap['status'];
      name=jsonMap['name'];
      phone=jsonMap['phone'];
    }
    catch(e){
      id='';
      planId='';
      vendorId='';
      planAmount='';
      createdDate='';
      expireDate='';
      planName ='';
      shopName = '';
      status = '';
      name = '';
      phone = '';
    }

  }
  Map toMap(){
    Map map=Map<String,dynamic>();
    map['id']=id;
    map['planId']=planId;
    map['vendorId']=vendorId;
    map['planAmount']=planAmount;
    map['createdDate']=createdDate;
    map['planName']=planName;
    map['shopName']=shopName;
    map['status']=status;
    map['name']=name;
    map['phone']=phone;
    return map;
  }
}
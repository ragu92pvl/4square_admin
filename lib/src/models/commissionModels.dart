class CommissionReportModel{
  String id;
  String ShopName;
  String OrderAmount;
  String Commission;
  String SettleMentValue;
  String driver_fees;
  String overAllAmount;

  CommissionReportModel();
  CommissionReportModel.fromJSON(Map<String,dynamic> jsonMap){
    try{
      id=jsonMap['id'];
      ShopName=jsonMap['ShopName'];
      OrderAmount=jsonMap['OrderAmount'];
      Commission=jsonMap['Commission'];
      SettleMentValue=jsonMap['SettleMentValue'];
      driver_fees=jsonMap['driver_fees'];
      overAllAmount=jsonMap['overAllAmount'];
    }
    catch(e){

      id='';
      ShopName='';
      OrderAmount='';
      Commission='';
      SettleMentValue='';
      driver_fees='';
      overAllAmount='';
    }

  }
  Map toMap(){

    Map map=Map<String,dynamic>();
    map['id']=id;
    map['ShopName']=ShopName;
    map['OrderAmount']=OrderAmount;
    map['Commission']=Commission;
    map['SettleMentValue']=SettleMentValue;
    map['driver_fees']=driver_fees;
    map['overAllAmount']=overAllAmount;
    return map;
  }
}
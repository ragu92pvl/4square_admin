
class Dashboard {
  int newOrders =0;
  int processing =0;
  int outForDelivery =0;
  int completed =0;
  int newOrdersPercent =0;
  int processingPercent =0 ;
  int outForDeliveryPercent =0;
  int completePercent = 0;
  double totalEarnCod = 0;
  double totalEarnOnline = 0;
  double totalEarn = 0;
  double zone1TotalEarn = 0;
  double Zon1Earn = 0;
  double totalM416Earn = 0;
  double totalSettlementValue = 0;
  double totalSettlementValueZone1 = 0;
  double totalCustomerValue = 0;
  double zone1totalCustomerValue = 0;
  int vendorNew =0;
  int userNew =0;
  int driverNew =0;
  double thisMonthEarn = 0;


  Dashboard();

  Dashboard.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      newOrders = jsonMap['newOrders'] ;
      processing = jsonMap['processing'];
      outForDelivery = jsonMap['outForDelivery'];
      completed = jsonMap['completed'];
      newOrdersPercent = jsonMap['newOrdersPercent']!=null?jsonMap['newOrdersPercent']:0;
      processingPercent = jsonMap['processingPercent']!=null?jsonMap['processingPercent']:0;
      outForDeliveryPercent = jsonMap['outForDeliveryPercent']!=null?jsonMap['outForDeliveryPercent']:0;
      completePercent = jsonMap['completePercent']!=null?jsonMap['completePercent']:0;
      totalEarnCod = jsonMap['totalEarnCod'];
      thisMonthEarn = jsonMap['thisMonthEarn'].toDouble()!=null?jsonMap['thisMonthEarn'].toDouble():0;
      totalEarnOnline = jsonMap['totalEarnOnline'];
      totalEarn = jsonMap['totalEarn'];
      zone1TotalEarn = jsonMap['zone1TotalEarn'];
      totalM416Earn = jsonMap['totalM416Earn'];
      Zon1Earn = jsonMap['Zon1Earn'];
      totalSettlementValue = jsonMap['totalSettlementValue'];
      totalSettlementValueZone1 = jsonMap['totalSettlementValueZone1'];
      totalCustomerValue = jsonMap['totalCustomerValue'];
      zone1totalCustomerValue = jsonMap['zone1totalCustomerValue'];
      vendorNew = jsonMap['vendorNew'];
      userNew = jsonMap['userNew'];
      driverNew = jsonMap['driverNew'];
    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["newOrders"] = newOrders;
    map["processing"] = processing;
    map["outForDelivery"] = outForDelivery;
    map["completed"] = completed;
    map["newOrdersPercent"] = newOrdersPercent;
    map["processingPercent"] = processingPercent;
    map["outForDeliveryPercent"] = outForDeliveryPercent;
    map["completePercent"] = completePercent;
    map["totalEarnCod"] = totalEarnCod;
    map["totalEarnOnline"] = totalEarnOnline;
    map["Zon1Earn"] = Zon1Earn;
    map["totalEarn"] = totalEarn;
    map["zone1TotalEarn"] = zone1TotalEarn;
    map["vendorNew"] = vendorNew;
    map["userNew"] = userNew;
    map["driverNew"] = driverNew;




    return map;
  }


}

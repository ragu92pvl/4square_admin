class DriverRegistermodel {
  String id;
  String firstname;
  String lastname;
  String dob;
  String age;
  String gender;
  String address1;
  String address2;
  String city;
  String state;
  String zipcode;
  double latitude;
  double longtitude;
  String email;
  String mobile;
  String password;
  String profile;
  var image;
  String zone;
  String licenseno;
  String aboutyou;
  String drivingMode;
  String storeId;
  String status;
  String liveStatus;
  String date;
  bool block;
  bool isPasswordChange = false;
  String totalEarnings;
  String totalSale;
  int totalSaleCount;



  DriverRegistermodel();

  DriverRegistermodel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      firstname = jsonMap['firstname'];
      totalSale = jsonMap['totalSale'];
      totalSaleCount = jsonMap['totalSaleCount'];
      id = jsonMap['id'];
      lastname = jsonMap['lastname'] != null ? jsonMap['lastname'].toString() : null;
      dob = jsonMap['dob'];
      age = jsonMap['age'];
      drivingMode = jsonMap['drivingMode'];
      storeId = jsonMap['storeId'];
      gender = jsonMap['gender'] != null ? jsonMap['gender'] : null;
      address1 = jsonMap['address1'] != null ? jsonMap['address1'] : null;
      address2 = jsonMap['address2'];
      city = jsonMap['city'];
      state = jsonMap['state'];
      zipcode = jsonMap['zipcode'];
      latitude = jsonMap['latitude'];
      longtitude = jsonMap['longtitude'];
      zone = jsonMap['zone'];
      email = jsonMap['email'];
      mobile = jsonMap['mobile'];
      password = jsonMap['password'];
      profile = jsonMap['profile'];
      licenseno = jsonMap['licenseno'];
      aboutyou = jsonMap['aboutyou'];
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      status=jsonMap['status'];
      date=jsonMap['date'];
      age=jsonMap['age'];
      totalEarnings=jsonMap['totalEarnings'];
      liveStatus = jsonMap['livestatus'] != null ? jsonMap['livestatus'] : '';
      block = jsonMap['block'] != null ? jsonMap['block'] : '';

    } catch (e) {
      firstname = '';
      lastname = '';
      drivingMode = '';
      storeId = '';
      dob = '';
      gender = '';
      address1 = '';
      address2 = '';
      city = '';
      state = '';
      zipcode = '';
      latitude = 0.0;
      longtitude = 0.0;
      email = '';
      mobile = '';
      password = '';
      profile = '';
      licenseno = '';
      aboutyou = '';
      totalEarnings = '';
      totalSale = '';
      totalSaleCount = 0;

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['id']=id;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["dob"] = dob;
    map["age"] = age;
    map["gender"] = gender;
    map["address1"] = address1;
    map["address2"] = address2;
    map["city"] = city;
    map["state"] = state;
    map["zipcode"] = zipcode;
    map["latitude"] = latitude;
    map["longtitude"] = longtitude;
    map["email"] = email;
    map["mobile"] = mobile;
    map["password"] = password;
    map["isPasswordChange"] = isPasswordChange;
    map["profile"] = profile;
    map["licenseno"] = licenseno;
    map["drivingMode"] = drivingMode;
    map["storeId"] = storeId;
    map["zone"] = zone;
    map['image']=image;
    map['totalEarnings']=totalEarnings;
    return map;
  }
}
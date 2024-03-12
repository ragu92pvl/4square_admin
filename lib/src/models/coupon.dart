

class Coupon{
  String id;
  String title;
  String addedBy;
  String till;
  String code;
  String status;
  var image;
  String discountType;
  String discount;
  String terms;
  String minimumPurchasedAmount;
  String limit;
  String couponType;


  Coupon();
  Coupon.fromJSON(Map<String,dynamic> jsonMap){
    title=jsonMap['title'].toString();
    id=jsonMap['id'].toString();
    addedBy=jsonMap['addedBy'].toString();
    till=jsonMap['till'].toString();
    code=jsonMap['code'].toString();
    status=jsonMap['status'].toString();
    image = jsonMap['image'];
    couponType=jsonMap['couponType'].toString();
    limit=jsonMap['limit'].toString();
    discountType=jsonMap['discountType'].toString();
    discount=jsonMap['discount'].toString()!= null ? jsonMap['discount'].toString() :  0.0;
    terms=jsonMap['terms'].toString();
    //minimumPurchasedAmount= jsonMap['minimumPurchasedAmount'].toDouble()!= null ? jsonMap['minimumPurchasedAmount'].toDouble() :  0.0;
  }
  Map toMap(){
    var map=Map<String,dynamic>();
    map['title']=title;
    map['addedBy']=addedBy;
    map['till']=till;
    map['code']=code;
    map['status']=status;
    map['discountType']=discountType;
    map['discount']=discount;
    map['terms']=terms;
    map['couponType']=couponType;
    map['limit']=limit;
    map['minimumPurchasedAmount']=minimumPurchasedAmount;
    return map;
  }
}
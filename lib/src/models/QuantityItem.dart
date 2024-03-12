class QuantityItem {
  String id;
  String productName;
  String price;
  String strike;
  int offer;
  String quantity;
  int qty;
  String variant;
  String variantValue;
  String userId;
  String cartId;
  String unit;
  String shopId;
  String image;
  double tax;
  String discount;
  int packingCharge;
  List<Null> addon;

  QuantityItem(
      {this.id,
        this.productName,
        this.price,
        this.strike,
        this.offer,
        this.quantity,
        this.qty,
        this.variant,
        this.variantValue,
        this.userId,
        this.cartId,
        this.unit,
        this.shopId,
        this.image,
        this.tax,
        this.discount,
        this.packingCharge,
        this.addon});

  QuantityItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    price = json['price'];
    strike = json['strike'];
    offer = json['offer'];
    quantity = json['quantity'];
    qty = json['qty'];
    variant = json['variant'];
    variantValue = json['variantValue'];
    userId = json['userId'];
    cartId = json['cartId'];
    unit = json['unit'];
    shopId = json['shopId'];
    image = json['image'];
    tax = json['tax'];
    discount = json['discount'];
    packingCharge = json['packingCharge'];
    if (json['addon'] != null) {
      addon = new List<Null>();
      // json['addon'].forEach((v) {
      //   addon.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['strike'] = this.strike;
    data['offer'] = this.offer;
    data['quantity'] = this.quantity;
    data['qty'] = this.qty;
    data['variant'] = this.variant;
    data['variantValue'] = this.variantValue;
    data['userId'] = this.userId;
    data['cartId'] = this.cartId;
    data['unit'] = this.unit;
    data['shopId'] = this.shopId;
    data['image'] = this.image;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['packingCharge'] = this.packingCharge;
    if (this.addon != null) {
      data['addon'] = null;
    }
    return data;
  }
}
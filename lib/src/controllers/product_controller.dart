import 'package:flutter/cupertino.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../models/shopRating.dart';
import '../models/shopratingmodel.dart';
import '../repository/product_repository.dart' as repository;
import '../repository/user_repository.dart';

class ProductController extends ControllerMVC {
  GlobalKey<FormState> categoryFormKey;
  GlobalKey<FormState> subcategoryFormKey;
  GlobalKey<FormState> productFormKey;

  List<DropDownModel> dropDownList = <DropDownModel>[];
  List<DropDownModel> subDropDownList = <DropDownModel>[];
  List<ShopRatingModels> shopReviewList = <ShopRatingModels>[];
  // ignore: non_constant_identifier_names

  OverlayEntry loader;
  ProductController() {
    loader = Helper.overlayLoader(context);
    subcategoryFormKey =  new GlobalKey<FormState>();
    productFormKey = new GlobalKey<FormState>();
    categoryFormKey = new GlobalKey<FormState>();
  }



  void shopTypeChange(id,status){
    repository.updateShopTypeStatus(id,status).then((value) {
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use

    });
  }


  void listenForShopReview(int id) async {
    final Stream<ShopRatingModels> stream = await getShopReviewlist(id);
    stream.listen((ShopRatingModels _product) {
      setState(() {
        shopReviewList.add(_product);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {

    });
  }





  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  Future<void> listenForSubDropdown(table, select, column, para1) async {
    subDropDownList.clear();

    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => subDropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }




  productStatus(productId,status){

      repository.updateProductStatus(productId,status).then((value) {
        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use

      });
  }




  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
}
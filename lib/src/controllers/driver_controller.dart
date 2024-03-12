

import 'package:flutter/cupertino.dart';
import 'package:login_and_signup_web/src/models/driver_pending_amount_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/src/repository/driver_repsitory.dart';

import '../helpers/helper.dart';

class DriverController extends ControllerMVC{

  DriverPendingAmountModel pendingAmountModel = DriverPendingAmountModel();
  List<Map<String, dynamic>> originalSource = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  bool isLoading = true;
  OverlayEntry loader;
  DriverController(){
    loader = Helper.overlayLoader(context);
  }

  Future<void> driverPendingAmount(driverId) async {
    originalSource.clear();
    source.clear();
    setState(() => isLoading = true);
    final Stream<Map<String, dynamic>> stream = await repDriverPendingAmount(driverId);
    stream.listen((Map<String, dynamic> _list) {
      setState(() => source.add(_list));
      setState(() => originalSource.add(_list));
      setState(() => isLoading = false);
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  Future<void> driverCompleteAmount(driverId) async {
    originalSource.clear();
    source.clear();
    setState(() => isLoading = true);
    final Stream<Map<String, dynamic>> stream = await repDriverCompleteAmount(driverId);
    stream.listen((Map<String, dynamic> _list) {
      setState(() => source.add(_list));
      setState(() => originalSource.add(_list));
      setState(() => isLoading = false);
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> changeSettlement(invoiceId,driverId) async {

    Overlay.of(context).insert(loader);
    await changeSettlementStatus(invoiceId).then((value) {
      driverPendingAmount(driverId);
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
    }).whenComplete(() {
      Helper.hideLoader(loader);
      //  listenForVendorSettlementList(vendorId);
      // Navigator.pop(context);
    });

  }

}
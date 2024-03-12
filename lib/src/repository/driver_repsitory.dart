
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/models/driver_pending_amount_model.dart';

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';

// ignore: missing_return
Future<Stream<Map<String, dynamic>>> repDriverPendingAmount(driverId) async {
  DriverPendingAmountModel res;
  // ignore: deprecated_member_use
  Uri uri = Helper.getUri('Api_admin/pendingDriverAmount/$driverId');
  print('Api_admin/pendingDriverAmount/$driverId');
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => data);
  } catch (e) {
    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    // return new Stream.value(new PaymentReport.fromJSON({}));
  }
}

// ignore: missing_return
Future<Stream<Map<String, dynamic>>> repDriverCompleteAmount(driverId) async {
  DriverPendingAmountModel res;
  // ignore: deprecated_member_use
  Uri uri = Helper.getUri('Api_admin/completeDriverAmount/$driverId');
  print('Api_admin/completeDriverAmount/$driverId');
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => data);
  } catch (e) {
    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    // return new Stream.value(new PaymentReport.fromJSON({}));
  }
}

Future<bool> changeSettlementStatus(invoiceId) async {
  // ignore: deprecated_member_use
  final url =
      "${GlobalConfiguration().getString('base_url')}Api_admin/driverChangeSettlement/$invoiceId";
  print(url);
  bool res;
  final client = new http.Client();
  final response = await client.get(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  if (response.statusCode == 200) {
    if (json.decode(response.body)['success'] == true) {
      res = true;
    } else {
      res = false;
    }
  } else {
    throw new Exception(response.body);
  }
  return res;
}

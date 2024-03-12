import 'dart:convert';
import 'dart:io';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/walletmodel.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';

Future<Stream<DropDownModel>> getDropdownDataNC(table, select) async {

 Uri uri = Helper.getUri('Api_admin/globaldropdown/$table/$select/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => DropDownModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DropDownModel.fromJSON({}));
 }
}

Future<WalletModel> getWalletBanner(id) async {
 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString(
     'api_base_url')}api_vendor/walletSystem/banner/$id';

 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );

 if (response.statusCode == 200) {

  return  WalletModel.fromJSON(json.decode(response.body)['data']);
 } else {
  throw new Exception(response.body);
 }


}

getSingleValue(table, col1, para1, select) async {

 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/getGlobalObject/$table/$col1/$para1/$select';

 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );

 if (response.statusCode == 200) {
  return json.decode(response.body)['data'];
 } else {
  throw new Exception(response.body);
 }


}


Future<Stream<DropDownModel>> getDropdownDataSC(table, select, column, para1) async {

 Uri uri = Helper.getUri('Api_admin/globaldropdownsc/$table/$select/$column/$para1/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => DropDownModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DropDownModel.fromJSON({}));
 }
}






Future<bool> updateProductStatus(productId,status) async {
 Uri uri = Helper.getUri('Api_vendor/product/product_status/$productId/$status');

 final client = new http.Client();
 final response = await client.post(
  uri,
  headers:
  {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );


 if (response.statusCode == 200) {
  return true;
 } else {
  return false;
 }
}

Future<bool> updateShopTypeStatus(id,status) async {
 var shopStatus = 0;
 if(status){
  shopStatus = 1;
 }else{
  shopStatus = 0;
 }
 Uri uri = Helper.getUri('Api_admin/shopTypeStatusChange/$id/$shopStatus');

 final client = new http.Client();
 final response = await client.post(
  uri,
  headers:
  {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );


 if (response.statusCode == 200) {
  return true;
 } else {
  return false;
 }
}
import 'dart:convert';
import 'dart:io';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/driverregistermodel.dart';
import 'package:login_and_signup_web/src/models/user_model.dart';
import 'package:login_and_signup_web/src/models/vendorAll.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';

import '../models/profile_response_new.dart';
import '../models/zone.dart';

Future<Stream<VendorAllModel>> getVendorList(zoneId) async {
  Uri uri = Helper.getUri('Api_admin/vendor/list/null/${currentUser.value.id}/$zoneId');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => VendorAllModel.fromJSON(data));
  } catch (e) {
    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new VendorAllModel.fromJSON({}));
  }
}

// ignore: non_constant_identifier_names
Future<bool> VendorDelete(id) async {
  // ignore: deprecated_member_use
  Uri uri =
      Helper.getUri('Api_admin/vendor/delete/$id/${currentUser.value.id}');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  bool res;
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );
  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    if (json.decode(response.body)['data'] == 'success') {
      res = true;
    } else {
      res = false;
    }
  } else {
    throw new Exception(response.body);
  }
  return res;
}

Future<bool> globalDelete(String table, id) async {
  // ignore: deprecated_member_use
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}api_admin/globalDelete/$table/$id';
  print(url);
  bool res;
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    if (json.decode(response.body)['data'] == 'success') {
      res = true;
    } else {
      res = false;
    }
  } else {
    throw new Exception(response.body);
  }
  return res;
}

Future<bool> vendorDelete(id) async {
  // ignore: deprecated_member_use
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}api_admin/globalDelete/$id';
  print(url);
  bool res;
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );
  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    if (json.decode(response.body)['data'] == 'success') {
      res = true;
    } else {
      res = false;
    }
  } else {
    throw new Exception(response.body);
  }
  return res;
}

Future<Stream<UserModel>> getUserList() async {
  Uri uri = Helper.getUri('Api_admin/user/list/${currentUser.value.id}');
  print('Api_admin/user/list/${currentUser.value.id}');
  print(uri);
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  print(currentUser.value.apiToken);
  print(currentUser.value.phone);
  print(currentUser.value.auth);
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => UserModel.fromJSON(data));
  } catch (e) {
    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new UserModel.fromJSON({}));
  }
}

addWallet(type, id, amount) async {
  // ignore: deprecated_member_use
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}api_admin/addDebitAmount/$id/$type/$amount';
  print(url);
  bool res;
  // final client = new http.Client();
  // final response = await client.get(
  //  Uri.parse(url),
  //  headers: {HttpHeaders.contentTypeHeader: 'application/json'}
  // );
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    if (json.decode(response.body)['data'] == 'success') {
      res = true;
    } else {
      res = false;
    }
  } else {
    throw new Exception(response.body);
  }
  return res;
}

Future<Stream<DriverRegistermodel>> getDriverList() async {
  Uri uri =
      Helper.getUri('Api_admin/driverregister/list/${currentUser.value.id}/${currentUser.value.zoneId}/${currentUser.value.role}');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => DriverRegistermodel.fromJSON(data));
  } catch (e) {
    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new DriverRegistermodel.fromJSON({}));
  }
}

Future<Stream<ZoneModel>> getZone() async {

  Uri uri = Helper.getUri('Api_admin/Zone/');
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
        .map((data) => ZoneModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ZoneModel.fromJSON({}));
  }
}




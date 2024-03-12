import 'dart:convert';
import 'dart:math';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/elements/PaymentDetailsViewWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/adminApprovedStatus.dart';
import 'package:login_and_signup_web/src/models/otherservicerequestlist.dart';
import 'package:login_and_signup_web/src/models/payment_report.dart';
import 'package:login_and_signup_web/src/models/vendorRequestList.dart';
import 'package:login_and_signup_web/src/pages/dashboard.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/adminApprovedStatus.dart';
import '../models/vendorRequestList.dart';

class RequestPayments extends StatefulWidget {
  RequestPayments({Key key}) : super(key: key);
  @override
  _RequestPaymentsState createState() => _RequestPaymentsState();
}

class _RequestPaymentsState extends State<RequestPayments> {
  OtherServiceRequestList otherServiceRequestList;

  String approved, userid, amount, id;
  String _chosenValue;
  String value = 'Pending';

  @override
  void initState() {
    super.initState();
    getVendorRequestList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(
                maxHeight: 700,
              ),
              child: Card(
                elevation: 1,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: DataTable2(
                  columnSpacing: 18,
                  horizontalMargin: 50,
                  minWidth: 650,
                  dataRowHeight: 100,

                  //source: RowSource(),
                  columns: [
                    DataColumn2(
                      label: Text('ID'),
                    ),
                    DataColumn(
                      label: Text('User Name'),
                    ),
                    DataColumn(
                      label: Text('From Location'),
                    ),
                    DataColumn(
                      label: Text('To Location'),
                    ),
                    DataColumn(
                      label: Text('Description'),
                    ),
                    DataColumn(
                      label: Text('Delivery Fees'),
                    ),
                    DataColumn(
                      label: Text('Status'),
                    ),
                  ],
                  rows: otherServiceRequestList.addservicedata.map((e) {
                    print(e.id);
                    print(e.fromname);

                    return DataRow(cells: [
                      DataCell(Text(e.id)),
                      DataCell(Text(e.fromname)),
                      DataCell(Text(e.fromlocation)),
                      DataCell(Text(e.tolocation)),
                      DataCell(Text(e.description)),
                      DataCell(Text(e.deliveryfees + "" + "Rs")),
                      DataCell(
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            // color: e.paymentStatus == 'Approved'
                            //     ? Colors.green
                            //     : Colors.redAbccent,
                            color: _getColorByEvent(e.status),

                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: DropdownButton<String>(
                            focusColor: Colors.white,

                            value: _chosenValue,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: <String>['Approved', 'Rejected']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              e.status,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                {
                                  if (e.status == 'Approved' ||
                                      e.status == 'Rejected') {
                                    final snackBar = SnackBar(
                                      content: const Text(
                                          'Already Status was changed'),
                                      backgroundColor: (Colors.red),
                                      action: SnackBarAction(
                                        label: 'dismiss',
                                        onPressed: () {},
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    String id = e.id;
                                    _chosenValue = value;
                                    if (value == 'Approved') {
                                      approved = 'Approved';
                                      showAlertDialog(context, approved, id);
                                    } else if (value == 'Rejected') {
                                      approved = 'Rejected';
                                      showAlertDialog(context, approved, id);
                                    }
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ])),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _initData();
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  showAlertDialog(BuildContext context, String status, String id) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        print("id:" + id);
        print(status);
        getAdminrequestdetails(id, status);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Action"),
      content: status == '0'
          ? Text("Would you like to Approval the  Request ?")
          : Text("Would you like to Rejected the  Request ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getVendorRequestList() async {
    // ${GlobalConfiguration().getString('api_base_url')}
    try {
      var url = Uri.parse(
          "${GlobalConfiguration().getString('api_base_url')}/Api_admin/otherservicesList/");

      var response = await get(url);
      print(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        setState(() {
          otherServiceRequestList =
              OtherServiceRequestList.fromJson(jsonResponse);
        });
        print(otherServiceRequestList.addservicedata.length);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getAdminrequestdetails(String id, String status) async {
    try {
      var url = Uri.parse(
          "${GlobalConfiguration().getString('api_base_url')}/Api_admin/otherservicesUpdate/$id/$status/");
      var response = await get(url);
      print(url);
      print(status);
      print(id);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        setState(() {
          // adminApprovedStatus = AdminApprovedStatus.fromJson(jsonResponse);
          getVendorRequestList();
        });
        Navigator.of(context, rootNavigator: true).pop();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

Color _getColorByEvent(String event) {
  if (event == "Approved") return Colors.green;
  if (event == "Rejected") return Colors.red;
  return Colors.blue;
}

class MyData extends DataTableSource {
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000)
          });

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
    ]);
  }
}

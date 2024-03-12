

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

import '../controllers/driver_controller.dart';

class DriverCompletedPayment extends StatefulWidget {

  String driverId;

  DriverCompletedPayment(this.driverId);

  @override
  _DriverCompletedPaymentState createState() => _DriverCompletedPaymentState();
}

class _DriverCompletedPaymentState extends StateMVC<DriverCompletedPayment> {

  DriverController con;
  List<Map<String, dynamic>> _selecteds = List<Map<String, dynamic>>();
  bool _isSearch = false;

  _DriverCompletedPaymentState() : super(DriverController()) {
    con = controller;
  }

  String _sortColumn;
  bool _sortAscending = true;


  List<DatatableHeader> _headers = [

    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),

    DatatableHeader(
        text: "ORDER ID",
        value: "orderId",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),

    DatatableHeader(
        text: "ORDER DATE",
        value: "orderDate",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),

    DatatableHeader(
        text: "DRIVER EARNINGS",
        value: "settlementAmount",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),


    DatatableHeader(
        text: "DRIVER TIPS",
        value: "driverTips",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),

    DatatableHeader(
        text: "SETTLEMENT",
        value: "total",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),


    DatatableHeader(
      text: "Status",
      value: "status",
      show: true,
      sortable: true,
      textAlign: TextAlign.left,
      sourceBuilder: (value, row) {

        return Container(

          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              Badge(
                toAnimate: false,
                shape: BadgeShape.square,
                badgeColor: Colors.red,
                borderRadius: BorderRadius.circular(8),
                badgeContent: Text(value, style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.driverCompleteAmount(widget.driverId);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child:SingleChildScrollView(
            child:Column(
                children:[
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
                      child: ResponsiveDatatable(

                        actions: [
                          if (_isSearch)
                            Expanded(
                                child: TextField(
                                  onChanged: (e){

                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              _isSearch = false;
                                            });
                                          }),
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.search), onPressed: () {})),
                                )),
                          if (!_isSearch)
                            IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  setState(() {
                                    _isSearch = true;
                                  });
                                })
                        ],
                        headers: _headers,
                        source: con.source,
                        selecteds: _selecteds,
                        autoHeight: false,
                        onTabRow: (data) {
                          print(data);
                        },
                        onSort: (value) {
                          setState(() {
                            _sortColumn = value;
                            _sortAscending = !_sortAscending;
                            if (_sortAscending) {
                              con.source.sort((a, b) =>
                                  b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                            } else {
                              con.source.sort((a, b) =>
                                  a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                            }
                          });
                        },
                        sortAscending: _sortAscending,
                        sortColumn: _sortColumn,
                        isLoading: con.isLoading,


                      ),
                    ),
                  ),
                ]
            )
        )

    );
  }
}

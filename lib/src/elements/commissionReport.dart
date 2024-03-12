import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/membership_plan_history.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../models/commissionModels.dart';

class CommissionReport extends StatefulWidget {
  @override
  _CommissionReportState createState() => _CommissionReportState();
}

class _CommissionReportState extends StateMVC<CommissionReport> with SingleTickerProviderStateMixin {
  UserController _con;

  _CommissionReportState() : super(UserController()) {
    _con = controller;
  }
  List<CommissionReportModel> itemList=<CommissionReportModel>[];



  int rowsperpage=5;
  @override
  void initState() {
    super.initState();
    _con.commissionHistory();
    itemList=_con.commission;
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    //itemList.length<10? rowsperpage=5:rowsperpage=10;
    final _dtSource = UserDataTableSource(
      userData: itemList,
    );
    return SingleChildScrollView(
        child:Column(
          children: [
            itemList.isEmpty?EmptyOrdersWidget():Container(
              width: size.width,
              child: CustomPaginatedTable(
                actions: [
                  Container(
                      height: 40,
                      width: 130,
                      decoration: BoxDecoration(color:Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                          border:Border.all(
                              width: 1,
                              color:Theme.of(context).dividerColor
                          )
                      ),
                      child: TextField(
                        autofocus: false,
                        onChanged: (e){
                          setState((){

                            itemList =_con.filtermemberhistoryplan(_con.vendorPlanListTemp, e);

                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: S.of(context).search,
                          hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                          labelText: S.of(context).search,
                          labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 14)),
                          suffixIcon: IconButton(
                            icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                        ),
                      ))
                ],
                dataColumns: [
                  DataColumn(
                    label: Text('S.No'),
                  ),
                  DataColumn(
                    label: Text('Shop Name'),
                  ),
                  DataColumn(
                    label: Text('Order Amount'),
                  ),
                  DataColumn(
                    label: Text('Commission'),
                  ),
                  DataColumn(
                    label: Text('Settlement'),
                  ),
                  // DataColumn(
                  //   label: Text('Delivery fees'),
                  // ),
                  // DataColumn(
                  //   label: Text('Action'),
                  // ),

                ],
                header:  Row(
                  children: [
                    Text('Commission Report'),
                  ],
                ),
                onRowChanged: (index) => setState(() {rowsperpage=index;}),
                rowsPerPage: rowsperpage,//_prosvider.rowsPerPage,
                showActions: true,
                source: _dtSource,
                //sortColumnIndex: _provider.sortColumnIndex,
                //sortColumnAsc: _provider.sortAscending,
              ),
            )
          ],
        ));
  }

}
class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    List<CommissionReportModel> userData,
  })  : itemList = userData,

        assert(userData != null);

  final List<CommissionReportModel> itemList;

  //final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= itemList.length) {
      return null;
    }
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[

        DataCell(Text((index + 1).toString() ?? '0.0')),
        DataCell(Text(itemList [index].ShopName ?? '0.0')),
        DataCell(Text(itemList [index].OrderAmount ?? '0.0')),
        DataCell(Text(itemList [index].Commission ?? '0.0')),
        DataCell(Text(itemList [index].SettleMentValue ?? '0.0')),
       // DataCell(Text(itemList [index].driver_fees ?? '0.0')),
       // DataCell(Text("View"?? '0.0')),

      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => itemList.length;

  @override
  int get selectedRowCount => 0;


}

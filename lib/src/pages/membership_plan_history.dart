import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/membership_plan_history.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
class MembershipPlanHistory extends StatefulWidget {
  @override
  _MembershipPlanHistoryState createState() => _MembershipPlanHistoryState();
}

class _MembershipPlanHistoryState extends StateMVC<MembershipPlanHistory> with SingleTickerProviderStateMixin {
  UserController _con;

  _MembershipPlanHistoryState() : super(UserController()) {
    _con = controller;
  }
  List<VendorPlanHistory> itemList=<VendorPlanHistory>[];
  int rowsperpage=5;
  @override
  void initState() {
    super.initState();
    _con.listenForPlanHistory();
    itemList=_con.vendorPlanList;
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
                    label: Text(S.of(context).history_id),
                  ),
                  DataColumn(
                    label: Text(S.of(context).User_Name),
                  ),
                  DataColumn(
                    label: Text(S.of(context).Phone_Number),
                  ),
                  DataColumn(
                    label: Text(S.of(context).plan_name),
                  ),
                  DataColumn(
                    label: Text(S.of(context).plan_amount),
                  ),
                  DataColumn(
                    label: Text(S.of(context).Status),
                  ),
                  DataColumn(
                    label: Text(S.of(context).created_date),
                  ),
                  DataColumn(
                    label: Text(S.of(context).expire_date),
                  ),
                ],
                header:  Text(S.of(context).membership_history),
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
    List<VendorPlanHistory> userData,
  })  : itemList = userData,

        assert(userData != null);

  final List<VendorPlanHistory> itemList;

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
        DataCell(Text((index + 1).toString() ?? ' ')),
        DataCell(Text(itemList [index].id ?? ' ')),
        DataCell(Text(itemList [index].name ?? ' ')),
        DataCell(Text(itemList [index].phone ?? ' ')),
        DataCell(Text(itemList [index].planName ?? ' ')),
        DataCell(Text(Helper.pricePrint(itemList [index].planAmount ?? ' '))),
        DataCell(itemList [index].status == '1' ? Text('Active',style: TextStyle(color:Colors.green),) : Text('InActive',style: TextStyle(color: Colors.red),)),
        DataCell(Text(itemList [index].createdDate ?? ' ')),
        DataCell(Text(itemList [index].expireDate ?? ' ')),
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

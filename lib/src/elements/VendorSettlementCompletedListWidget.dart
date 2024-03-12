import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import '../models/payment_report.dart';
import 'EmptyOrdersWidget.dart';
import 'WalletDetailsViewWidget.dart';


// ignore: must_be_immutable
class VendorSettlementCompletedListWidget extends StatefulWidget {

String type;
int vendorId;

VendorSettlementCompletedListWidget({Key key,  this.type,this.vendorId}) : super(key: key);

@override
_VendorSettlementCompletedListWidgetState createState() => _VendorSettlementCompletedListWidgetState();
}

class _VendorSettlementCompletedListWidgetState extends StateMVC<VendorSettlementCompletedListWidget> {
  SecondaryController _con;
  bool _isSearch = false;
  List<Map<String, dynamic>> _selecteds = List<Map<String, dynamic>>();
  String _sortColumn;
  bool _sortAscending = true;

  _VendorSettlementCompletedListWidgetState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  void initState() {
    print(widget.type);
    // TODO: implement initState
    super.initState();
    _con.listenForVendorSettlementCompleteList(widget.vendorId);

  }

  @override
  Widget build(BuildContext context) {


    List<DatatableHeader> _headers = [

      DatatableHeader(
          text: "ID",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),

      DatatableHeader(
          text: "From Date",
          value: "fromdate",
          show: true,
          flex: 2,
          sortable: true,
          editable:false,
          textAlign: TextAlign.left),

      DatatableHeader(
        text: "Last Date",
        value: "lastdate",
        show: true,
        sortable: true,
        textAlign: TextAlign.left,

      ),


      DatatableHeader(
          text: "Order Count",
          value: "count",
          show: true,
          flex: 2,
          sortable: true,
          editable:false,
          textAlign: TextAlign.left),

      DatatableHeader(
          text: "Order Amount",
          value: "vorderamount",
          show: true,
          sortable: true,

          sourceBuilder: (value, row) {

            return Container(child:Text(Helper.pricePrint(value)));},
          textAlign: TextAlign.center),
      DatatableHeader(
          text: S.of(context).commission,
          value: "vcommission",
          show: true,
          sortable: true,
          sourceBuilder: (value, row) {

            return Container(child:Text(Helper.pricePrint(value)));},
          textAlign: TextAlign.left),

      DatatableHeader(
          text: "Settlement",
          value: "vsettlementvalue",
          show: true,
          sortable: true,
          sourceBuilder: (value, row) {

            return Container(child:Text(Helper.pricePrint(value)));},
          textAlign: TextAlign.left),

      DatatableHeader(
        text: "Settlement Date",
        value: "settlementDate",
        show: true,
        sortable: true,
        textAlign: TextAlign.left,

      ),

      DatatableHeader(
        text: "Transaction ID",
        value: "transactionId",
        show: true,
        sortable: true,
        textAlign: TextAlign.left,

      ),


      DatatableHeader(
        text: "Action",
        value: "action",
        show: true,
        sortable: true,
        textAlign: TextAlign.left,
        sourceBuilder: (value, row) {

          return Container(

            child: InkWell(
              onTap: (){
               // _con.changeSettlement(row['fromdate'],row['lastdate'],widget.vendorId);
              },
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Badge(
                    toAnimate: false,
                    shape: BadgeShape.square,
                    badgeColor: Colors.white30,
                    borderRadius: BorderRadius.circular(8),
                    badgeContent: Text("Settled", style: TextStyle(color: Colors.black)),
                  ),

                ],
              ),
            ),
          );
        },),






    ];



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
                                    setState((){
                                      //_con.settlementSource = filterListReport(_con.originalSettlementSource, e);
                                    });
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
                        source: _con.settlementCompleteSource,
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
                              _con.settlementCompleteSource.sort((a, b) =>
                                  b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                            } else {
                              _con.settlementCompleteSource.sort((a, b) =>
                                  a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                            }
                          });
                        },
                        sortAscending: _sortAscending,
                        sortColumn: _sortColumn,
                        isLoading: _con.isLoading,


                      ),
                    ),
                  ),
                ]
            )
        )

    );
  }


// filterListReport( List<Map<String, dynamic>> list, String filterString) {
//
//   List<PaymentReport> tempList = list.map<PaymentReport>((json)=>PaymentReport.fromJSON(json)).toList();
//
//
//   List<PaymentReport> _list = tempList
//       .where(( u) =>
//   (u.paymentMethod.toLowerCase().contains(filterString.toLowerCase()) || u.invoiceID.toLowerCase().contains(filterString.toLowerCase()) || u.transactionID.toLowerCase().contains(filterString.toLowerCase())) ).toList();
//   //  List<Map<String, dynamic>> _result =  _list.cast();
//   List<Map<String, dynamic>> _result = _list.map<Map<String, dynamic>>((json)=> Map<String, dynamic>.from(json.toMap()) ).toList();
//   print(_result.length);
//   return _result;
// }

}
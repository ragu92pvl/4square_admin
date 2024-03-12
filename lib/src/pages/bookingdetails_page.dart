
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/hservice_controller.dart';
import 'package:login_and_signup_web/src/elements/BookingTrackViewWidget.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/ViewBookingDetailsWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({Key key}) : super(key: key);

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends StateMVC<BookingDetailsPage> {
  HServiceController _con;
  int rowsperpage=5;
  _BookingDetailsPageState() : super(HServiceController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForProviderBooking();
    super.initState();
  }
  //_con.bookingDetailsList.length<10? rowsperpage=5:rowsperpage=10;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _dtSource = UserDataTableSource(
      con: _con,
      context: context,
    );
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Div(
                colS: 12,
                colM: 12,
                colL: 12,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //SizedBox(height: 20),
                  /**Container(
                      width: size.width * 0.9,
                      margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                      child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                      Div(
                      colS: 6,
                      colM: 6,
                      colL: 6,
                      child: Wrap(children: [
                      Text(
                      S.of(context).booking_details,
                      style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(width: 10),
                      ])),
                      /*Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                      textAlign: TextAlign.left,
                      autocorrect: true,
                      //initialValue: widget.details.title,
                      //onSaved: (input) =>  widget.con.bannerData.title = input,
                      validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                      labelText: S.of(context).search,
                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                      ),
                      ),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      color:
                      Theme.of(context).accentColor,
                      width: 1.0,
                      ),
                      ),
                      )),
                      )*/
                      ]),
                      )**/
                  //SizedBox(height: 10),
                  SizedBox(
                    height: 10,
                  ),
                  _con.bookingDetailsList.isEmpty?EmptyOrdersWidget():Container(
                    width: size.width,
                    child: CustomPaginatedTable(
                      actions: <IconButton>[
                        IconButton(
                          splashColor: Colors.transparent,
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            _con.listenForProviderBooking();
                            //_provider.fetchData();
                            //_showSBar(context, DataTableConstants.refresh);
                          },
                        ),
                      ],
                      dataColumns: [
                        DataColumn(
                          label: Text('No'),
                        ),
                        DataColumn(
                          label: Text(S.of(context).book_id),
                        ),
                        DataColumn(
                          label: Text(S.of(context).user_name),
                        ),
                        DataColumn(
                          label: Text(S.of(context).provider_name),
                        ),
                        DataColumn(
                          label: Text(S.of(context).phone),
                        ),
                        DataColumn(
                          label: Text(S.of(context).date),
                        ),
                        DataColumn(
                          label: Text(S.of(context).status),
                        ),
                        DataColumn(
                          label: Text(S.of(context).option),
                        ),

                      ],
                      header:  Text('Booking Details'),
                      onRowChanged: (index) => setState(() {rowsperpage=index;}),
                      rowsPerPage: rowsperpage,//_prosvider.rowsPerPage,
                      showActions: true,
                      source: _dtSource,
                      //sortColumnIndex: _provider.sortColumnIndex,
                      //sortColumnAsc: _provider.sortAscending,
                    ),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}

class ViewTrackPopup {
  static exit(context, trackViewList, orderId) => showDialog(
      context: context,
      builder: (context) => BookingTrackViewWidget(
        bookingStatus: trackViewList,
        orderId: orderId,
      ));
}

class ViewBookingDetailsPopup {
  static exit(context, bookingDetails) => showDialog(
      context: context,
      builder: (context) => ViewBookingDetailsWidget(
        bookingDetails: bookingDetails,
      ));
}
class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    BuildContext context,

    HServiceController con,

    //this.onRowSelect,
  })  :context=context,
        _con=con;


  final context;
  HServiceController _con;


  //final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text((index + 1).toString())),
        DataCell(Text(_con.bookingDetailsList[index].bookId ?? '')),
        DataCell(Text(_con.bookingDetailsList[index].userName ?? '')),
        DataCell(Text(_con.bookingDetailsList[index].providerName ?? '')),
        DataCell(Text(_con.bookingDetailsList[index].phone ?? '')),
        DataCell(Text(_con.bookingDetailsList[index].date ?? '')),

        DataCell(
          Container(
              width: 75,
              height: 25,
              child:
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){},
                  color: Colors.green,
                  shape: StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      _con.bookingDetailsList[index].status??'',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .primaryColorLight)),
                    ),
                  )
              )
          ),
        ),
        DataCell(Row(
          children: [
            Container(
                width: 75,
                height: 25,
                child:
                // ignore: deprecated_member_use
                FlatButton(onPressed: ()
                {
                  ViewTrackPopup.exit(
                      context, _con.bookingDetailsList[index].bookingStatusManage, _con.bookingDetailsList[index].bookId);
                },
                    color: Colors.blue,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Track',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .primaryColorLight)),
                      ),
                    )
                )
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                width: 75,
                height: 25,
                child:
                // ignore: deprecated_member_use
                FlatButton(onPressed: (){ViewBookingDetailsPopup.exit(context, _con.bookingDetailsList[index].bookingDetails);},
                    color: Colors.teal,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        S.of(context).profile,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .primaryColorLight)),
                      ),
                    )
                )
            ),



          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _con.bookingDetailsList.length;

  @override
  int get selectedRowCount => 0;


}

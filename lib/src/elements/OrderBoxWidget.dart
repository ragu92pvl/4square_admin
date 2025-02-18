import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/elements/AssignDriverPopup.dart';
import 'package:login_and_signup_web/src/elements/AutoAssignWidget.dart';
import 'package:login_and_signup_web/src/elements/PrescriptionPopup.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import '../models/reject_reasons.dart';
import 'InvoiceWidget.dart';
import 'DriverDetailViewWidget.dart';

// ignore: must_be_immutable
class OrderBoxWidget extends StatefulWidget {
  OrderList orderDetails;
  String tabTab;
  OrderController con;
  String pageType;

  OrderBoxWidget(
      {Key key, this.orderDetails, this.tabTab, this.con, this.pageType})
      : super(key: key);

  @override
  _OrderBoxWidgetState createState() => _OrderBoxWidgetState();
}

class _OrderBoxWidgetState extends State<OrderBoxWidget> {
  String _type = '1';

  @override
  Widget build(BuildContext context) {
    print(widget.tabTab);
    return InkWell(
      child: Div(
        colS: 12,
        colM: 12,
        colL: 6,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 1.0,
              ),
            ],
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: EdgeInsets.only(left: 15, right: 15, top: 10.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topLeft,
                  children: [
                    Positioned.fill(
                      left: -15,
                      top: -10,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 30, left: 1),
                          child: Image(
                              image: widget.tabTab == 'Placed'
                                  ? AssetImage('assets/img/waiting.png')
                                  : widget.tabTab == 'Accepted'
                                      ? AssetImage('assets/img/preparing.png')
                                      : widget.tabTab == 'Packed'
                                          ? AssetImage('assets/img/ready.png')
                                          : widget.tabTab == 'Shipped'
                                              ? AssetImage(
                                                  'assets/img/shipped.png')
                                              : widget.tabTab == 'Delivered'
                                                  ? AssetImage(
                                                      'assets/img/completed.png')
                                                  : AssetImage(
                                                      'assets/img/cancelled.png'),
                              fit: BoxFit.fitWidth,
                              width: 84,
                              height: 45),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 18, right: 18, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Wrap(children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 70),
                                  child: Column(
                                    children: [
                                      Text(
                                          'ID -${widget.orderDetails.orderId}'),
                                      Text(
                                          'ID -${widget.orderDetails.shopName}'),
                                    ],
                                  ),
                                ),
                              ])),
                              SizedBox(width: 5),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Wrap(children: [
                                      widget.orderDetails.orderType == '2'
                                          ? Tooltip(
                                              message: widget
                                                  .orderDetails.deliverSlot,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.timer),
                                              ),
                                            )
                                          : Text(''),
                                      widget.orderDetails.pImage == 'no_image'
                                          // ignore: deprecated_member_use
                                          ? FlatButton(
                                              onPressed: () {
                                                //  VRouter.of(context).pushNamed('invoice', pathParameters: {'id':'1'});

                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                InvoiceWidget(
                                                                  orderID: int.parse(widget
                                                                      .orderDetails
                                                                      .orderId),
                                                                )));
                                              },
                                              shape: Border.all(
                                                  width: 1.0,
                                                  color: Colors.blue),
                                              padding: EdgeInsets.all(15),
                                              child: Text(
                                                S.of(context).view_detail,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                      color: Colors.blue,
                                                    )),
                                              ),
                                              // ignore: deprecated_member_use
                                            )
                                          // ignore: deprecated_member_use
                                          : FlatButton(
                                              onPressed: () {
                                                if (widget.orderDetails.price ==
                                                    '0') {
                                                  AddPrescriptionPopupHelper
                                                      .exit(
                                                          context,
                                                          widget.orderDetails,
                                                          'amount',
                                                          widget.con);
                                                }
                                              },
                                              shape: Border.all(
                                                  width: 1.0,
                                                  color: Colors.blue),
                                              padding: EdgeInsets.all(15),
                                              child: Text(
                                                'Update Amount',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                      color: Colors.blue,
                                                    )),
                                              ),
                                            ),
                                    ]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        child: Text(widget.orderDetails.date))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // widget.orderDetails.pImage == 'no_image'
                              //     ? Container(
                              //   height: 35,
                              //   width: 35,
                              //   alignment: Alignment.center,
                              //   decoration: BoxDecoration(
                              //     image: DecorationImage(image: NetworkImage(widget.orderDetails.itemImage), fit: BoxFit.fill),
                              //     shape: BoxShape.circle,
                              //     color: Colors.white,
                              //     boxShadow: [
                              //       BoxShadow(color: Colors.grey, blurRadius: 5.0),
                              //     ],
                              //   ),
                              // )
                              //     : Container(),
                              // SizedBox(
                              //   width: 13.0,
                              // ),

                              Expanded(
                                child: Wrap(
                                  children: [
                                    // widget.orderDetails.pImage == 'no_image' ? Container(
                                    //   padding: EdgeInsets.only(top: 10),
                                    //   child: Text(
                                    //     '${widget.orderDetails.productName}   +${widget.orderDetails.itemTotal}',
                                    //   ),
                                    // )
                                    //     : Text(''),
                                    // widget.orderDetails.pImage != 'no_image'
                                    //     ? IconButton(
                                    //     onPressed: () {
                                    //       AddPrescriptionPopupHelper.exit(context, widget.orderDetails, 'image', widget.con);
                                    //     },
                                    //     icon: Icon(Icons.description))
                                    //     : Container(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                            children: List.generate(
                                                widget.orderDetails.itemName
                                                    .length, (index) {
                                              return Container(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.arrow_right_alt),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        widget
                                                                .orderDetails
                                                                .itemName[index]
                                                                .qty
                                                                .toString() +
                                                            " X " +
                                                            widget
                                                                .orderDetails
                                                                .itemName[index]
                                                                .productName,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                widget.orderDetails.paymentType,
                              ),
                              IconButton(
                                  onPressed: () {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) =>
                                    //       statusUpdate(),
                                    // );
                                  },
                                  icon: Icon(
                                    Icons.strikethrough_s_sharp,
                                    color: Colors.red,
                                  ))
                              //FlatButton(onPressed: openDropdown, child: Text('CLICK ME')),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey[200])))),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(children: [
                            Expanded(
                                child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                  Text(
                                    Helper.pricePrint(
                                        widget.orderDetails.price),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    '${S.of(context).contact}: ${widget.orderDetails.username} - ${widget.orderDetails.contact}',
                                  ),
                                ]))),
                            SizedBox(width: 10),

                            Wrap(children: [

                              // 1 == 2
                              // ignore: deprecated_member_use
                              if (widget.tabTab != "Cancelled") ...[
                                widget.tabTab != "Delivered"
                                    ? FlatButton(
                                        onPressed: () {
                                          _showMyDialog();
                                        },
                                        padding: EdgeInsets.all(8),
                                        color: Colors.red,
                                        shape: StadiumBorder(),
                                        child: Text(
                                          S.of(context).cancel,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .merge(TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ),
                                      )
                                    : Container()
                              ] else ...[
                                Container(),
                              ], // : Container(),
                              SizedBox(width: 10),

                              widget.tabTab == 'Placed'
                                  // ignore: deprecated_member_use
                                  ? FlatButton(
                                      onPressed: () {
                                        widget.con.updateOrderStatus(
                                            widget.orderDetails.orderId,
                                            'Accepted',
                                            widget.orderDetails);
                                      },
                                      padding: EdgeInsets.all(8),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(1),
                                      shape: StadiumBorder(),
                                      child: Text(
                                        S.of(context).confirm,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(
                                                TextStyle(color: Colors.white)),
                                      ),
                                    )
                                  : widget.tabTab == 'Accepted'
                                      // ignore: deprecated_member_use
                                      ? FlatButton(
                                          onPressed: () {
                                            // widget.con.updateOrderStatus(
                                            //     widget.orderDetails.orderId,
                                            //     'Packed',
                                            //     widget.orderDetails);
                                            widget.con.showToast("Currently not supported");
                                          },
                                          padding: EdgeInsets.all(8),
                                          color: Colors.black87,
                                          shape: StadiumBorder(),
                                          child: Text(
                                            S.of(context).ready,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          // ignore: deprecated_member_use
                                        )
                                      : widget.tabTab == 'Packed' &&
                                              widget.pageType != 'takeaway'
                                          // ignore: deprecated_member_use
                                          ? FlatButton(
                                              onPressed: () {
                                                // widget.con.updateOrderStatus(widget.orderDetails.orderId, 'Shipped', widget.orderDetails);
                                                if (currentUser
                                                        .value.autoAssign ==
                                                    true) {
                                                  AutoAssignPopupHelper.exit(
                                                      context,
                                                      widget.con,
                                                      widget
                                                          .orderDetails.orderId,
                                                      widget.orderDetails);
                                                } else {
                                                  AssignDriverPopupHelper.exit(
                                                      context,
                                                      widget.con,
                                                      widget
                                                          .orderDetails.orderId,
                                                      widget.orderDetails);
                                                }
                                              //  widget.con.showToast("Currently not supported");
                                              },
                                              padding: EdgeInsets.all(8),
                                              color: Colors.green,
                                              shape: StadiumBorder(),
                                              child: Text(
                                                'Ready to ship',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            )
                                          : widget.pageType == 'takeaway' &&
                                                  widget.tabTab != 'Delivered'
                                              // ignore: deprecated_member_use
                                              ? FlatButton(
                                                  onPressed: () {
                                                    widget.con
                                                        .updateOrderStatus(
                                                            widget.orderDetails
                                                                .orderId,
                                                            'Delivered',
                                                            widget
                                                                .orderDetails);
                                                  },
                                                  padding: EdgeInsets.all(8),
                                                  color: Colors.green,
                                                  shape: StadiumBorder(),
                                                  child: Text(
                                                    S.of(context).delivered,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .merge(TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                )
                                              : widget.pageType == 'takeaway' &&
                                                      widget.tabTab ==
                                                          'Delivered'
                                                  ? Text('')
                                                  : widget.tabTab != 'Cancelled'
                                                      ? Wrap(children: [
                                                          Icon(Icons
                                                              .electric_bike),
                                                          SizedBox(width: 10),
                                                          // ignore: deprecated_member_use
                                                          FlatButton(
                                                            onPressed: () {
                                                              // widget.con.updateOrderStatus(widget.orderDetails.orderId, 'Shipped', widget.orderDetails);

                                                              DriverDetailsPopupHelper.exit(
                                                                  context,
                                                                  widget.con,
                                                                  widget
                                                                      .orderDetails
                                                                      .orderId);
                                                            },
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            color: Colors.green,
                                                            shape:
                                                                StadiumBorder(),
                                                            child: Text(
                                                              'Driver Details',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  .merge(TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                          ),

                                                        ])
                                                      : Container(),
                              SizedBox(width: 10,),
                              widget.tabTab == "Rejected" ?  FlatButton(
                                onPressed: () {
                                  // widget.con.updateOrderStatus(widget.orderDetails.orderId, 'Shipped', widget.orderDetails);
                                  if (currentUser
                                                        .value.autoAssign ==
                                                    true) {
                                                  AutoAssignPopupHelper.exit(
                                                      context,
                                                      widget.con,
                                                      widget
                                                          .orderDetails.orderId,
                                                      widget.orderDetails);
                                                } else {
                                                  AssignDriverPopupHelper.exit(
                                                      context,
                                                      widget.con,
                                                      widget
                                                          .orderDetails.orderId,
                                                      widget.orderDetails);
                                                }
                                 // widget.con.showToast("Currently not supported");
                                },
                                padding: EdgeInsets.all(8),
                                color: Colors.green,
                                shape: StadiumBorder(),
                                child: Text(
                                  'Confirm & Assign Boy',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(
                                      color: Colors.white)),
                                ),
                              ):Container(),

                            ])
                          ]

                          ),

                          SizedBox(
                            height: 20,
                          ),
                          widget.tabTab == "Cancelled" ?
                          widget.orderDetails.cancelReason !=null ? Text("Reason: "+widget.orderDetails.cancelReason.replaceAll("%20", " "),style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),):SizedBox()
                              :SizedBox(),
                          widget.tabTab == "Rejected" ? InkWell(
                              onTap: (){
                                _showFullScreenDialog(context,widget.orderDetails.rejectReasons);
                              },
                              child: Text("Show Rejected Reasons",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)):SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullScreenDialog(BuildContext context, List<RejectReasons> rejectReasons) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: _buildDialogContent(context,rejectReasons),
        );
      },
    );
  }


  Widget _buildDialogContent(BuildContext context, List<RejectReasons> rejectReasons) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reasons',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          // Add your dialog content here
          rejectReasons.length>0 ? ListView.builder(
              shrinkWrap: true,
              itemCount: rejectReasons.length,
              itemBuilder: (BuildContext context, int index){
                var dataBean = rejectReasons[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    dataBean.reason.replaceAll("%20", " ")+" (${dataBean.name} - ${dataBean.phone}/${dataBean.createdAt})",
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              }):Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'No Reject Reason found.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure to cancel this order?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                widget.con.updateOrderStatus(widget.orderDetails.orderId,
                    'Cancelled', widget.orderDetails);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  statusUpdate() {
    return AlertDialog(
      title: Text(S.of(context).confirm),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: double.infinity,
          child: DropdownButton(
              value: _type,
              isExpanded: true,
              focusColor: Theme.of(context).colorScheme.secondary,
              underline: Container(
                color: Colors.grey[300],
                height: 1.0,
              ),
              items: [
                DropdownMenuItem(
                  child: Text('Force Deliver'),
                  value: '1',
                ),
                DropdownMenuItem(
                  child: Text('Cancelled'),
                  value: '2',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _type = value;
                  print('type:$_type');
                  widget.con.orderData.status = value;
                });

                // widget.con.bannerData.type = value;
              }),
        );
      }),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
            onPressed: () {
              widget.con
                  .editOrderStatus(widget.orderDetails.orderId, widget.tabTab);
            },
            child: Text(S.of(context).update)),
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
      ],
    );
  }
}

class AssignDriverPopupHelper {
  static exit(context, con, orderId, details) => showDialog(
      context: context,
      builder: (context) =>
          ManualDriverPopup(con: con, orderId: orderId, orderDetails: details));
}

class AddPrescriptionPopupHelper {
  static exit(context, orderDetail, popType, con) => showDialog(
      context: context,
      builder: (context) => PrescriptionPopup(
            orderDetails: orderDetail,
            popType: popType,
            con: con,
          ));
}

class AutoAssignPopupHelper {
  static exit(context, con, orderId, details) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AutoAssignWidget(
            con: con,
            orderId: orderId,
            orderDetails: details,
          ));
}

class DriverDetailsPopupHelper {
  static exit(context, con, orderId) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DriverDetailViewWidget(
            orderId: orderId,
          ));
}

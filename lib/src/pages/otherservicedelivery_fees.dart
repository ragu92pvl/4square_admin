import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AEDeliveryFeesWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/delivery_Fees.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../elements/AEOtherserviceDeliveryFeesWidget.dart';
import '../models/othersevice_delivery_Fess.dart';

class OtherServiceDeliveryFee extends StatefulWidget {
  @override
  _OtherServiceDeliveryFeeState createState() =>
      _OtherServiceDeliveryFeeState();
}

class _OtherServiceDeliveryFeeState extends StateMVC<OtherServiceDeliveryFee> {
  SecondaryController _con;
  _OtherServiceDeliveryFeeState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.listenForOtherserviceDeliveryFees();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                      child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Div(
                                colS: 12,
                                colM: 12,
                                colL: 12,
                                child: Wrap(children: [
                                  Text(
                                    " Manage Other Service deliveryfees",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: Colors.white,
                                      icon: const Icon(Icons.add),
                                      iconSize: 30.0,
                                      //color: Palette.facebookBlue,
                                      onPressed: () {
                                        DeliveryFeesPopupHelper.exit(
                                            context,
                                            _con,
                                            OtherServiceDeliveryFees(),
                                            'add');
                                      },
                                    ),
                                  ),
                                ])),
                          ]),
                    ),
                    SizedBox(height: 20),
                    _con.otherservicedeliveryFeesList.isEmpty
                        ? EmptyOrdersWidget()
                        : Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 30),
                            child: Wrap(
                              children: List.generate(
                                  _con.otherservicedeliveryFeesList.length,
                                  (index) {
                                OtherServiceDeliveryFees
                                    _otherservicedeliveryFeesData = _con
                                        .otherservicedeliveryFeesList
                                        .elementAt(index);

                                return Div(
                                  colS: 12,
                                  colM: 6,
                                  colL: 4,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 10),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 20,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 1.0,
                                                ),
                                              ]),
                                          child: Column(
                                            children: [
                                              Wrap(children: [
                                                Div(
                                                  colS: 4,
                                                  colM: 4,
                                                  colL: 4,
                                                  child: Wrap(children: [
                                                    Text(
                                                      _otherservicedeliveryFeesData
                                                          .fromRange,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2
                                                          .merge(TextStyle(
                                                              color:
                                                                  Colors.brown,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                    SizedBox(width: 4),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 15),
                                                      child: Text(Helper
                                                          .printDistanceUnit()),
                                                    ),
                                                  ]),
                                                ),
                                                Div(
                                                  colS: 4,
                                                  colM: 4,
                                                  colL: 4,
                                                  child: Column(
                                                    children: [
                                                      Text(S.of(context).to,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle1),
                                                      Text(
                                                          S
                                                              .of(context)
                                                              .distance,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .caption),
                                                    ],
                                                  ),
                                                ),
                                                Div(
                                                  colS: 4,
                                                  colM: 4,
                                                  colL: 4,
                                                  child: Wrap(
                                                      alignment:
                                                          WrapAlignment.end,
                                                      children: [
                                                        Text(
                                                          _otherservicedeliveryFeesData
                                                              .toRange,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline2
                                                              .merge(TextStyle(
                                                                  color: Colors
                                                                      .brown,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                        SizedBox(width: 4),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                          child: Text(Helper
                                                              .printDistanceUnit()),
                                                        ),
                                                      ]),
                                                ),
                                              ]),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('ss',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .transparent)),
                                                  Text(
                                                    Helper.pricePrint(
                                                        _otherservicedeliveryFeesData
                                                            .fees),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                        .merge(TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Imagepickerbottomsheet(
                                                          _otherservicedeliveryFeesData
                                                              .id,
                                                          _otherservicedeliveryFeesData);
                                                    },
                                                    icon:
                                                        Icon(Icons.more_horiz),
                                                  )
                                                ],
                                              )
                                            ],
                                          ))),
                                );
                              }),
                            ),
                          ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, feesDetails) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                    Navigator.pop(context),
                    DeliveryFeesPopupHelper.exit(
                        context, _con, feesDetails, 'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () async {
                    await _con.delete('logistics_pricing', id);

                    Navigator.pop(context);
                    setState(() {
                      _con.otherservicedeliveryFeesList.clear();
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}

class DeliveryFeesPopupHelper {
  static exit(context, con, otherservicedeliveryFeesDetails, pageType) =>
      showDialog(
          context: context,
          builder: (context) => OtherServiceDeliveryFeesPopup(
                con: con,
                otherservicedeliveryFeesDetails:
                    otherservicedeliveryFeesDetails,
                pageType: pageType,
              ));
}

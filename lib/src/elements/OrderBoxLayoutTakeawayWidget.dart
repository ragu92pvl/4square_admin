
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'EmptyOrdersWidget.dart';
import 'OrderBoxWidget.dart';
// ignore: must_be_immutable
class OrderBoxLayoutTakeawayWidget extends StatefulWidget {
  String tabTab;
  OrderBoxLayoutTakeawayWidget({Key key, this.tabTab}) : super(key: key);
  @override
  _OrderBoxLayoutTakeawayWidgetState createState() => _OrderBoxLayoutTakeawayWidgetState();
}

class _OrderBoxLayoutTakeawayWidgetState extends StateMVC<OrderBoxLayoutTakeawayWidget> {


  OrderController _con;
  _OrderBoxLayoutTakeawayWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForOrderListTakeaway(widget.tabTab);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _con.orderList.isEmpty? EmptyOrdersWidget()
        :Container(
      child: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
            child:Responsive(
                children:[
                  Div(
                      colS:12,
                      colM:12,
                      colL:12,
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Wrap(
                              children: List.generate(_con.orderList.length, (index) {
                                return OrderBoxWidget(orderDetails: _con.orderList.elementAt(index), tabTab: widget.tabTab, con:_con, pageType: 'takeaway',);
                              }
                              ),
                            ),
                          ]
                      )

                  )


                ]
            )
        ),
      ),

    );
  }
}

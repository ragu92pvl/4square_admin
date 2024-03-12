
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'EmptyOrdersWidget.dart';
import 'OrderBoxWidget.dart';
// ignore: must_be_immutable
class OrderBoxLayoutWidget extends StatefulWidget {
  String tabTab;
  OrderBoxLayoutWidget({Key key, this.tabTab}) : super(key: key);
  @override
  _OrderBoxLayoutWidgetState createState() => _OrderBoxLayoutWidgetState();
}

class _OrderBoxLayoutWidgetState extends StateMVC<OrderBoxLayoutWidget> {


  OrderController _con;
  _OrderBoxLayoutWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForOrderList(widget.tabTab,'Orders');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
            child:Responsive(
                children:[
                  Center(
                    child: Container(
                      child:SizedBox.fromSize(
                        size: Size(56, 56), // button width and height
                        child: ClipOval(
                          child: Material(
                            color: Colors.orange, // button color
                            child: InkWell(
                              splashColor: Colors.green, // splash color
                              onTap: () {
                                setState(() {
                                  _con.listenForOrderList(widget.tabTab,'Orders');
                                });
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.refresh), // icon
                                  Text("Refresh"), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ) ,
                    ),
                  ),
                  _con.orderList.isEmpty? EmptyOrdersWidget() :Div(
                      colS:12,
                      colM:12,
                      colL:12,
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Wrap(
                              children: List.generate(_con.orderList.length, (index) {
                                return OrderBoxWidget(orderDetails: _con.orderList.elementAt(index), tabTab: widget.tabTab, con:_con);
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../elements/DriverCompletedPayment.dart';
import '../elements/DriverPendingPayment.dart';

class DriverPaymentHistory extends StatefulWidget {

 String driverId;

 DriverPaymentHistory({this.driverId});

  @override
  State<DriverPaymentHistory> createState() => _DriverPaymentHistoryState();
}

class _DriverPaymentHistoryState extends State<DriverPaymentHistory>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(text: "Pending",),
              Tab(text: "Completed",),

            ],
          ),
          title: Text('Payment History'),
        ),
        body: TabBarView(
          children: [
            Container(child: DriverPendingPayment(widget.driverId)),
             Container(child: DriverCompletedPayment(widget.driverId)),
          ],
        ),
      ),
    );
  }

}


import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/elements/OrderBoxLayoutWidget.dart';
import 'package:login_and_signup_web/src/components/custome_switch2.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'ordersearch_box.dart';
class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends StateMVC<Orders>  with SingleTickerProviderStateMixin{
  TabController _tabController;
  OrderController _con;
  _OrdersState() : super(OrderController()) {
    _con = controller;
  }
  bool status=true;
  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this);
    if(GetPlatform.isDesktop){
      Helper.fireBaseDeskTopCon();
    }
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:0),
      child:Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]

          Container(
            color:Theme.of(context).primaryColor.withOpacity(0.6),
            child:Container(
              margin: EdgeInsets.only(left: 20.0, top: 40.0, right: 20, bottom: 10.0),

              child:Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children:[
                    Div(
                        colS:9,
                        colM:8,
                        colL:8,
                        child:Wrap(
                            children:[

                              Padding(
                                padding: EdgeInsets.only(top:7),
                                child:Text(
                                    S.of(context).order,
                                    style: Theme.of(context).textTheme.headline4
                                ),
                              ),
                              SizedBox(width:10),


                              GestureDetector(
                                onTap: () async{
                                  final String _apiToken = 'api_token=${ currentUser.value.apiToken}';
                                  // ignore: deprecated_member_use
                                  final url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/export_action/orders/${currentUser.value.id}?$_apiToken';


                                  if (await canLaunch(url)) {
                                    await launch(
                                      url,
                                      forceSafariVC: false,
                                    );
                                  }
                                },
                                child:Padding(
                                    padding:EdgeInsets.only(left:8,top:8),
                                    child:Image(image:AssetImage('assets/img/excel.png'),
                                        width:25,height:25
                                    )
                                ),
                              ),

                              Container(
                                  padding:EdgeInsets.only(left:20,top:7),
                                child:AutoSwitch()
                              ),
                            ]
                        )
                    ),
                    Div(
                      colS:3,
                      colM:4,
                      colL:4,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[

                            Padding(
                              padding:EdgeInsets.only(right:30),
                              child:IconButton(
                                onPressed:(){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxOrder(orderList: _con.orderListTemp,)));
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxOrder()));
                                },
                                icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                              ),
                            ),


                          ]
                      ),
                    ),

                  ]
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 45,
            decoration:BoxDecoration(
              color:Theme.of(context).primaryColor.withOpacity(0.6),
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicatorWeight: 2.0,
              isScrollable: true,
              indicatorColor: Color(0xFF5e078e),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.teal,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                    child:Container(
                      child: Text(S.of(context).new_orders,style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child:Container(
                      child: Text(S.of(context).prepared,style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),
                Tab(
                    child:Container(
                      child: Text(S.of(context).packed,style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child:Container(
                      child: Text(S.of(context).shipped,style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),
                Tab(
                    child:Container(
                      child: Text("Completed",style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child:Container(
                      child: Text(S.of(context).cancelled,style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),
                Tab(
                    child:Container(
                      child: Text("Rejected",style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),
              ],
            ),
          ),
          // tab bar view here
          SizedBox(height:5),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                OrderBoxLayoutWidget(tabTab: 'Placed'),
                OrderBoxLayoutWidget(tabTab: 'Accepted'),
                OrderBoxLayoutWidget(tabTab: 'Packed'),
                OrderBoxLayoutWidget(tabTab: 'Shipped'),
                OrderBoxLayoutWidget(tabTab: 'Delivered'),
                OrderBoxLayoutWidget(tabTab: 'Cancelled'),
                OrderBoxLayoutWidget(tabTab: 'Rejected'),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
class AutoSwitch extends StatefulWidget {
  @override
  _AutoSwitchState createState() => _AutoSwitchState();
}

class _AutoSwitchState extends State<AutoSwitch>   {

  bool isSwitched = false;

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return CustomSwitch2(
      activeColor: Colors.black,
      value: currentUser.value.autoAssign,

      onChanged: (value) {
        if(currentUser.value.autoAssign){
          currentUser.value.autoAssign = false;
        } else {
          currentUser.value.autoAssign = true;
        }
        setCurrentUser(currentUser.value);


      },
    );
  }
}

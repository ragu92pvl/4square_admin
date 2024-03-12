import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/elements/OrderBoxLayoutTakeawayWidget.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'ordersearch_box.dart';
class OrdersTakeaway extends StatefulWidget {
  @override
  _OrdersTakeawayState createState() => _OrdersTakeawayState();
}

class _OrdersTakeawayState extends StateMVC<OrdersTakeaway>  with SingleTickerProviderStateMixin{
  TabController _tabController;



  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);

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
                                    S.of(context).take_away_orders,
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
                              SizedBox(width:10),


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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxOrder(pageType: 'takeaway',)));
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
                      child: Text(S.of(context).delivered,style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child:Container(
                      child: Text(S.of(context).cancelled,style:TextStyle(fontWeight:FontWeight.w600)),
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

                OrderBoxLayoutTakeawayWidget(tabTab: 'Placed'),



                OrderBoxLayoutTakeawayWidget(tabTab: 'Accepted'),
                OrderBoxLayoutTakeawayWidget(tabTab: 'Packed'),


                OrderBoxLayoutTakeawayWidget(tabTab: 'Delivered'),


                OrderBoxLayoutTakeawayWidget(tabTab: 'Cancelled'),





              ],
            ),
          ),
        ],
      ),
    );



  }
}

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/VendorRegisterWidget.dart';
import 'package:login_and_signup_web/src/elements/VendorTabsWidget.dart';
import 'package:login_and_signup_web/src/models/vendorAll.dart';
import 'package:login_and_signup_web/src/pages/searchbox_vendor.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:vrouter/vrouter.dart';
import '../../generated/l10n.dart';
import '../models/zone.dart';

class VendorList extends StatefulWidget {
  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends StateMVC<VendorList>
    with SingleTickerProviderStateMixin {
  //TabController _tabController;

  PrimaryUserController _con;
  _VendorListState() : super(PrimaryUserController()) {
    _con = controller;
  }
  bool status = false;
  @override
  void initState() {
    //_tabController = TabController(length: 3, vsync: this);
    super.initState();
    _con.listenForVendor("");
    _con.listenForZone();
  }

  tabMaker() {
    // ignore: deprecated_member_use
    List<Tab> tabs = List();

    _con.vendorList.forEach((element) {
      tabs.add(Tab(
        text: element.shopType,
      ));
    });
    return tabs;
  }

  @override
  void dispose() {
    super.dispose();
    //_tabController.dispose();
  }

  ZoneModel selectedOption;

  @override
  Widget build(BuildContext context) {
    return _con.vendorList.isEmpty
        ? EmptyOrdersWidget()
        : DefaultTabController(
            length: _con.vendorList.length,
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  // give the tab bar a height [can change hheight to preferred height]

                  Container(
                    //color:Colors.white70,
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 20.0, top: 40.0, right: 20, bottom: 10.0),
                      child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Div(
                                colS: 9,
                                colM: 8,
                                colL: 8,
                                child: Wrap(children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 7),
                                    child: Text(S.of(context).vendor_list,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  ),
                                  SizedBox(width: 10),

                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () async {
                                      // ignore: deprecated_member_use
                                      var url =
                                          '${GlobalConfiguration().getString('api_base_url')}api_admin/export_action/vendor/${currentUser.value.id}';

                                      if (await canLaunch(url)) {
                                        await launch(
                                          url,
                                          forceSafariVC: false,
                                        );
                                      }
                                    },
                                    child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, top: 5),
                                        child: Image(
                                            image: AssetImage(
                                                'assets/img/excel.png'),
                                            width: 25,
                                            height: 25)),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    width: 200,
                                    child:  DropdownButton<ZoneModel>(
                                      hint: Text('Select Zone'), // Adding the hint
                                      value: selectedOption,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedOption = newValue;
                                          _con.vendorList.clear();
                                          _con.vendorsearchList.clear();
                                          _con.listenForVendor(selectedOption.id);
                                        });
                                      },
                                      items: _con.zoneList.map<DropdownMenuItem<ZoneModel>>((ZoneModel option) {
                                        return DropdownMenuItem<ZoneModel>(
                                          value: option,
                                          child: Text(option.title),
                                        );
                                      }).toList(),
                                    ),
                                  ),

                                  // Container(
                                  //     padding: EdgeInsets.only(left:10),
                                  //     child:IconButton(
                                  //         onPressed: (){
                                  //           VRouter.of(context).to('/vendormap');
                                  //         },
                                  //         icon:Icon(Icons.location_on,color:Colors.redAccent)
                                  //     )),
                                  // Container(
                                  //    margin: EdgeInsets.only(left:10,top:5),
                                  //    height: 30.0,
                                  //    width: 30.0,
                                  //    decoration: BoxDecoration(
                                  //      color: Colors.blue,
                                  //      shape: BoxShape.circle,
                                  //    ),
                                  //    child: IconButton(
                                  //      padding: EdgeInsets.zero,
                                  //      color: Colors.white,
                                  //      icon: const Icon(Icons.add),
                                  //      iconSize: 30.0,
                                  //      //color: Palette.facebookBlue,
                                  //      onPressed: () {
                                  //        AddVendorRegisterHelper.exit(context);
                                  //      },
                                  //    ),
                                  //  ),
                                ])),
                            Div(
                              colS: 3,
                              colM: 4,
                              colL: 4,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 30),
                                      child: IconButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchBoxVendor(
                                                        con: _con,
                                                        vendorList: _con
                                                            .vendorsearchList,
                                                      )));
                                        },
                                        icon: Icon(Icons.search,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                    ),
                                  ]),
                            ),
                          ]),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        //color:Colors.white70,
                        color: Theme.of(context).primaryColor.withOpacity(0.6)),
                    child: TabBar(
                        // controller: _tabController,
                        // give the indicator a decoration (color and border radius)
                        indicatorWeight: 2.0,
                        isScrollable: true,
                        indicatorColor: Color(0xFF5e078e),
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.teal,
                        tabs: tabMaker()),
                  ),
                  // tab bar view here
                  SizedBox(height: 5),
                  Expanded(
                    child: TabBarView(
                      // controller: _tabController,
                      children: List.generate(
                        _con.vendorList.length,
                        (index) {
                          VendorAllModel _vendorDetails =
                              _con.vendorList.elementAt(index);

                          return _vendorDetails.vendor.isNotEmpty ? VendorTabsWidget(
                            type: 1,
                            vendorList: _vendorDetails.vendor,
                            con: _con,
                          ):Center(child: Container(child: Center(child: Text("No Vendors Found")),));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class AddVendorRegisterHelper {
  static exit(context) =>
      showDialog(context: context, builder: (context) => VendorRegisterForm());
}

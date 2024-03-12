import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:vrouter/vrouter.dart';
import 'app_route_observer.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../repository/settings_repository.dart';

// ignore: must_be_immutable
class AppDrawer extends StatefulWidget {
  Function callback;
  AppDrawer({@required this.permanentlyDisplay, this.callback, Key key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with RouteAware {
  AppRouteObserver _routeObserver;
  @override
  void initState() {
    super.initState();
    _routeObserver = AppRouteObserver();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 240,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        // color: Colors.amberAccent,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Scrollbar(
        isAlwaysShown: true,
        child: Container(
          child: ListView(
            children: [
              CompanyName(),

              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: currentUser.value.image == 'no_image'
                                ? AssetImage("assets/img/logo.png")
                                : NetworkImage(currentUser.value.image),
                            fit: BoxFit.fill),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 25),
                    Expanded(
                        child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currentUser.value.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .merge(TextStyle(color: Colors.white))),
                            SizedBox(height: 5),
                            Text('Phone ${currentUser.value.phone}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .merge(TextStyle(color: Colors.white)))
                          ]),
                    )),
                  ],
                ),
              ),
              NavBar(
                callback: widget.callback,
              ),
              //NavBarItem(icon: Feather.log_out,navtext: '' , active: false,),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NavBar extends StatefulWidget {
  Function callback;
  NavBar({this.callback, Key key}) : super(key: key);
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<bool> selected = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  void select(int n, displayMobileLayout) {
    if (displayMobileLayout) {
      widget.callback();
    }
    for (int i = 0; i < 31; i++) {
      if (i != n) {
        selected[i] = false;
      } else {
        selected[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return currentUser.value.role != '4'
        ? Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavBarItem(
                  icon: Icons.control_point,
                  navtext: 'Role',
                  icon2: Icons.arrow_forward_ios,
                  active: selected[24],
                  touched: () {
                    VRouter.of(context).push('/role');
                    setState(() {
                      select(24, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Feather.home,
                  navtext: S.of(context).home,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[0],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).pushNamed('dashboard');

                    setState(() {
                      select(0, displayMobileLayout);
                    });
                  },
                ),

                NavBarItem(
                  icon: Feather.monitor,
                  navtext: S.of(context).banner,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[1],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/banner');
                    setState(() {
                      select(1, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Feather.anchor,
                  navtext: S.of(context).shop_type,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[2],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/shopType');
                    setState(() {
                      select(2, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Icons.chat,
                  navtext: S.of(context).chat,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[3],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/chat');
                    setState(() {
                      select(3, displayMobileLayout);
                    });
                  },
                ),

                NavBarItem(
                  icon: Icons.note,
                  navtext: S.of(context).review,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[4],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/review');
                    setState(() {
                      select(4, displayMobileLayout);
                    });
                  },
                ),
                // NavBarItem(
                //   icon: Feather.anchor,
                //   navtext: S.of(context).d_recommedation,
                //   icon2: Icons.arrow_forward_ios,
                //   active: selected[3],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/drecommendation');
                //     setState(() {
                //       select(3,displayMobileLayout);
                //     });
                //   },
                // ),
                NavBarItem(
                  icon: Icons.location_on,
                  navtext: S.of(context).zone,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[5],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/managezone');
                    setState(() {
                      select(5, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Icons.memory,
                  navtext: S.of(context).membership,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[6],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/membership');
                    setState(() {
                      select(6, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Feather.list,
                  navtext: S.of(context).commission_history,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[7],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/commissionreport');
                    setState(() {
                      select(7, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Feather.anchor,
                  navtext: 'Coupon',
                  icon2: Icons.arrow_forward_ios,
                  active: selected[8],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/coupon');
                    setState(() {
                      select(8, displayMobileLayout);
                    });
                  },
                ),
                // NavBarItem(
                //   icon: Feather.list,
                //   navtext:S.of(context).membership_history,
                //   icon2:  Icons.arrow_forward_ios,
                //   active: selected[9],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/membershiphistory');
                //     setState(() {
                //       select(9,displayMobileLayout);
                //     });
                //   },
                // ),
                // NavBarItem(
                //   icon: Icons.memory,
                //   navtext: S.of(context).membership,
                //   icon2:  Icons.arrow_forward_ios,
                //   active: selected[5],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/membership');
                //     setState(() {
                //       select(5,displayMobileLayout);
                //     });
                //   },
                // ),
                Container(
                    padding: EdgeInsets.only(
                      left: 2,
                      right: 2,
                    ),
                    child: Text(S.of(context).super_store,
                        style: Theme.of(context).textTheme.subtitle2.merge(
                            TextStyle(
                                color: Theme.of(context).primaryColorLight)))),

                NavBarItem(
                  icon: Icons.store,
                  navtext: S.of(context).vendor,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[10],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/vendorlist');
                    setState(() {
                      select(10, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Feather.box,
                  navtext: S.of(context).order,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[11],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/Order');
                    setState(() {
                      select(11, displayMobileLayout);
                    });
                  },
                ),
                // NavBarItem(
                //   icon: Feather.box,
                //   navtext: S.of(context).take_away,
                //   icon2: Icons.arrow_forward_ios,
                //   active: selected[9],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/takeaway');
                //     setState(() {
                //       select(9,displayMobileLayout);
                //     });
                //   },
                // ),
                NavBarItem(
                  icon: Feather.file,
                  navtext: S.of(context).payment,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[12],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/report');
                    setState(() {
                      select(12, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Feather.dollar_sign,
                  navtext: "Other Services",
                  icon2: Icons.arrow_forward_ios,
                  active: selected[4],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/otherservices');
                    setState(() {
                      select(4, displayMobileLayout);
                    });
                  },
                ),

                // NavBarItem(
                //     icon: Feather.anchor,
                //     navtext: S.of(context).settelment,
                //     icon2: Icons.arrow_forward_ios,
                //     active: selected[11],
                //     touched: () {
                //       // ignore: deprecated_member_use
                //       VRouter.of(context).push('/wallet');
                //       setState(() {
                //         select(11,displayMobileLayout);
                //       });
                //     },
                //   ),
                NavBarItem(
                  icon: Feather.user,
                  navtext: S.of(context).users,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[13],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/user');
                    setState(() {
                      select(13, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Icons.developer_board_outlined,
                  navtext: 'Cash on hand',
                  icon2: Icons.arrow_forward_ios,
                  active: selected[14],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/cashonhand');
                    setState(() {
                      select(14, displayMobileLayout);
                    });
                  },
                ),

                // Container(
                //     padding: EdgeInsets.only(left:2,right:2,),
                //     child:Text(S.of(context).handy_service,
                //         style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                //     )
                //
                // ),
                //
                // NavBarItem(
                //   icon: Icons.pedal_bike_rounded,
                //   navtext: S.of(context).category,
                //   icon2: Icons.arrow_forward_ios,
                //   active: selected[15],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/category');
                //     setState(() {
                //       select(15,displayMobileLayout);
                //     });
                //   },
                // ),
                // NavBarItem(
                //   icon: Icons.pedal_bike_rounded,
                //   navtext: S.of(context).sub_categories,
                //   icon2: Icons.arrow_forward_ios,
                //   active: selected[16],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/sub_category');
                //     setState(() {
                //       select(16,displayMobileLayout);
                //     });
                //   },
                // ),
                //
                // NavBarItem(
                //   icon: Feather.user,
                //   navtext: S.of(context).provider,
                //   icon2:  Icons.arrow_forward_ios,
                //   active: selected[17],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/provider');
                //     setState(() {
                //       select(17,displayMobileLayout);
                //     });
                //   },
                // ),
                NavBarItem(
                  icon: Icons.developer_board_outlined,
                  navtext: S.of(context).tax,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[15],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/tax');
                    setState(() {
                      select(15, displayMobileLayout);
                    });
                  },
                ),
                //
                // NavBarItem(
                //   icon: Feather.briefcase,
                //   navtext: S.of(context).booking_details,
                //   icon2: Icons.arrow_forward_ios,
                //   active: selected[19],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/bookingdetails');
                //     setState(() {
                //       select(19,displayMobileLayout);
                //     });
                //   },
                // ),
                // NavBarItem(
                //   icon: Feather.dollar_sign,
                //   navtext: S.of(context).payment_details,
                //   icon2: Icons.arrow_forward_ios,
                //   active: selected[20],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/paymentdetails');
                //     setState(() {
                //       select(20,displayMobileLayout);
                //     });
                //   },
                // ),
                /**NavBarItem(
            icon: Feather.monitor,
            navtext: 'Package',
            icon2: Icons.arrow_forward_ios,
            active: selected[1],
            touched: () {
              // ignore: deprecated_member_use
              VRouter.of(context).push('/package');
              setState(() {
                select(1,displayMobileLayout);
              });
            },
          ), */
                Container(
                    padding: EdgeInsets.only(
                      left: 2,
                      right: 2,
                    ),
                    child: Text(S.of(context).item_deliver,
                        style: Theme.of(context).textTheme.subtitle2.merge(
                            TextStyle(
                                color: Theme.of(context).primaryColorLight)))),
                NavBarItem(
                  icon: Icons.pedal_bike_rounded,
                  navtext: S.of(context).delivery_boy,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[16],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/driver');
                    setState(() {
                      select(16, displayMobileLayout);
                    });
                  },
                ),

                NavBarItem(
                  icon: Feather.coffee,
                  navtext: S.of(context).delivery_tips,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[17],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/delivery_tips');
                    setState(() {
                      select(17, displayMobileLayout);
                    });
                  },
                ),

                NavBarItem(
                  icon: Icons.ac_unit_sharp,
                  navtext: S.of(context).fees,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[18],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/deliveryfees');
                    setState(() {
                      select(18, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Icons.bike_scooter,
                  navtext: S.of(context).otherfees,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[18],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/otherservicedeliveryfees');
                    setState(() {
                      select(18, displayMobileLayout);
                    });
                  },
                ),
                Container(
                    padding: EdgeInsets.only(
                      left: 2,
                      right: 2,
                    ),
                    child: Text(S.of(context).general,
                        style: Theme.of(context).textTheme.subtitle2.merge(
                            TextStyle(
                                color: Theme.of(context).primaryColorLight)))),
                NavBarItem(
                  icon: Feather.bell,
                  navtext: S.of(context).notification,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[19],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/push_notification');
                    setState(() {
                      select(19, displayMobileLayout);
                    });
                  },
                ),
                // NavBarItem(
                //   icon:  Icons.policy,
                //   navtext: S.of(context).policy,
                //   icon2: Icons.arrow_forward_ios,
                //   active: selected[25],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/policy');
                //     setState(() {
                //       select(25,displayMobileLayout);
                //     });
                //   },
                // ),
                NavBarItem(
                  icon: Feather.anchor,
                  navtext: S.of(context).payment,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[26],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/payment_gateway');
                    setState(() {
                      select(26,displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Icons.developer_board_outlined,
                  navtext: 'Version Control',
                  icon2: Icons.arrow_forward_ios,
                  active: selected[20],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/version');
                    setState(() {
                      select(20, displayMobileLayout);
                    });
                  },
                ),
                // NavBarItem(
                //   icon: Feather.dollar_sign,
                //   navtext: S.of(context).currency,
                //   icon2: Icons.arrow_forward_ios,
                //   active: selected[27],
                //   touched: () {
                //     // ignore: deprecated_member_use
                //     VRouter.of(context).push('/currency');
                //     setState(() {
                //       select(27,displayMobileLayout);
                //     });
                //   },
                // ),

                NavBarItem(
                  icon: Feather.settings,
                  navtext: S.of(context).general_settings,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[21],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/general_settings');
                    setState(() {
                      select(21, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Feather.user,
                  navtext: S.of(context).manage_profile,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[22],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/profileView');
                    setState(() {
                      select(22, displayMobileLayout);
                    });
                  },
                ),
                // NavBarItem(
                //   icon: Feather.sun,
                //   navtext: Theme.of(context).brightness == Brightness.dark ? S.of(context).light : S.of(context).dark,
                //   icon2: Icons.arrow_forward_ios,
                //   active: selected[26],
                //   touched: () {
                //     if (Theme.of(context).brightness == Brightness.dark) {
                //     setBrightness(Brightness.light);
                //       setting.value.brightness.value = Brightness.light;
                //     } else {
                //       setting.value.brightness.value = Brightness.dark;
                //        setBrightness(Brightness.dark);
                //     }
                //     // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                //     setting.notifyListeners();
                //   },
                // ),

                NavBarItem(
                  icon: Feather.log_out,
                  navtext: S.of(context).logout,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[23],
                  touched: () {
                    if (currentUser.value.apiToken != null) {
                      logout().then((value) {
                        print('logout pressed');
                        //Toast.show('${S.of(context).logout} ${S.of(context).successfully}', context, duration: Toast.BOTTOM, gravity: Toast.LENGTH_SHORT ,);
                        // ignore: deprecated_member_use
                        VRouter.of(context).pushReplacement('/login');
                      });
                    } else {
                      // ignore: deprecated_member_use
                      VRouter.of(context).pushReplacement('/login');
                    }
                  },
                ),
                Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text('${S.of(context).version} 2.3',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .merge(TextStyle(color: Colors.white54)))),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavBarItem(
                  icon: Feather.box,
                  navtext: S.of(context).order,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[11],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/Order');
                    setState(() {
                      select(11, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Icons.pedal_bike_rounded,
                  navtext: S.of(context).delivery_boy,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[16],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/driver');
                    setState(() {
                      select(16, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Feather.coffee,
                  navtext: S.of(context).delivery_tips,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[17],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/delivery_tips');
                    setState(() {
                      select(17, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Icons.ac_unit_sharp,
                  navtext: S.of(context).fees,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[18],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/deliveryfees');
                    setState(() {
                      select(18, displayMobileLayout);
                    });
                  },
                ),
                NavBarItem(
                  icon: Feather.user,
                  navtext: S.of(context).manage_profile,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[22],
                  touched: () {
                    // ignore: deprecated_member_use
                    VRouter.of(context).push('/profileView');
                    setState(() {
                      select(22, displayMobileLayout);
                    });
                  },
                ),
               
                NavBarItem(
                  icon: Feather.log_out,
                  navtext: S.of(context).logout,
                  icon2: Icons.arrow_forward_ios,
                  active: selected[23],
                  touched: () {
                    if (currentUser.value.apiToken != null) {
                      logout().then((value) {
                        print('logout pressed');
                        VRouter.of(context).pushReplacement('/login');
                      });
                    } else {
                      VRouter.of(context).pushReplacement('/login');
                    }
                  },
                ),

                Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text('${S.of(context).version} 1.3',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .merge(TextStyle(color: Colors.white54)))),
              ],
            ),
          );
  }
}

class CompanyName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      color: Colors.white,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/img/logo.png'),
              width: 70,
              height: 70,
              fit: BoxFit.fitWidth,
            )
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final Function touched;
  final String navtext;
  final IconData icon2;
  final bool active;
  NavBarItem({this.icon, this.icon2, this.touched, this.active, this.navtext});
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // VRouter.of(context).push('/login');
            widget.touched();
          },
          splashColor: Colors.white,
          hoverColor: Colors.white12,
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 0.0),
                              child: Icon(
                                widget.icon,
                                color: widget.active
                                    ? Colors.white
                                    : Colors.white54,
                                size: 16.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                widget.navtext,
                                style: TextStyle(
                                  color: widget.active
                                      ? Colors.white
                                      : Colors.white54,
                                ),
                              ),
                            ),
                          ],
                        )),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            widget.icon2,
                            color:
                                widget.active ? Colors.white : Colors.white54,
                            size: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ])),
            ],
          )),
        ),
      )
    ]);
  }
}

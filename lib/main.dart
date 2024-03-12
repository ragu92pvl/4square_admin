import 'dart:io';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_and_signup_web/src/elements/Review.dart';
import 'package:login_and_signup_web/src/elements/chat_page.dart';
import 'package:login_and_signup_web/src/elements/commissionReport.dart';
import 'package:login_and_signup_web/src/elements/roles_widget.dart';
import 'package:login_and_signup_web/src/pages/Drecommendationpage.dart';
import 'package:login_and_signup_web/src/pages/Orders.dart';
import 'package:login_and_signup_web/src/pages/Orders_takeaway.dart';
import 'package:login_and_signup_web/src/pages/bookingdetails_page.dart';
import 'package:login_and_signup_web/src/pages/cashonhand.dart';
import 'package:login_and_signup_web/src/pages/category.dart';
import 'package:login_and_signup_web/src/pages/coupon_page.dart';
import 'package:login_and_signup_web/src/pages/currency.dart';
import 'package:login_and_signup_web/src/pages/delivery_doy.dart';
import 'package:login_and_signup_web/src/pages/delivery_tips.dart';
import 'package:login_and_signup_web/src/pages/dialogs.dart';
import 'package:login_and_signup_web/src/pages/general_settings.dart';
import 'package:login_and_signup_web/src/pages/dashboard.dart';
import 'package:login_and_signup_web/src/components/custom_switch.dart';
import 'package:login_and_signup_web/src/pages/delivery_fees.dart';
import 'package:login_and_signup_web/src/pages/m416Package.dart';
import 'package:login_and_signup_web/src/pages/managezone.dart';
import 'package:login_and_signup_web/src/pages/membership.dart';
import 'package:login_and_signup_web/src/pages/membership_plan_history.dart';
import 'package:login_and_signup_web/src/pages/packagedeatils.dart';
import 'package:login_and_signup_web/src/pages/paymentRequest.dart';
import 'package:login_and_signup_web/src/pages/payment_gateway.dart';
import 'package:login_and_signup_web/src/pages/paymentdetails_page.dart';
import 'package:login_and_signup_web/src/pages/policy.dart';
import 'package:login_and_signup_web/src/pages/profile.dart';
import 'package:login_and_signup_web/src/pages/provider.dart';
import 'package:login_and_signup_web/src/pages/push_notification.dart';
import 'package:login_and_signup_web/src/pages/report.dart';
import 'package:login_and_signup_web/src/pages/role/role_page.dart';
import 'package:login_and_signup_web/src/pages/shop_type.dart';
import 'package:login_and_signup_web/src/pages/slip.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/pages/subcategory.dart';
import 'package:login_and_signup_web/src/pages/supercategory.dart';
import 'package:login_and_signup_web/src/pages/taxpage.dart';
import 'package:login_and_signup_web/src/pages/user.dart';
import 'package:login_and_signup_web/src/pages/vendormappage.dart';
import 'package:login_and_signup_web/src/pages/version_control.dart';
import 'package:login_and_signup_web/src/pages/walletwidget.dart';
import 'package:login_and_signup_web/src/pages/zone.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'generated/l10n.dart';
import 'src/models/setting.dart';
import 'src/pages/otherservicedelivery_fees.dart';
import 'src/repository/settings_repository.dart' as settingRepo;
import 'src/repository/user_repository.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/elements/InvoiceWidget.dart';
import 'package:login_and_signup_web/src/elements/AppDrawer.dart';
import 'package:login_and_signup_web/src/pages/banners.dart';
import 'package:login_and_signup_web/src/pages/home.dart';
import 'package:login_and_signup_web/src/pages/languages.dart';
import 'package:login_and_signup_web/src/pages/vendor_list.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!GetPlatform.isDesktop) {
    Firebase.initializeApp();
  }
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDG4F-74mJcp1O7ZUuecamrf3sHglZDt1U",
          authDomain: "square-13f80.firebaseapp.com",
          projectId: "square-13f80",
          storageBucket: "square-13f80.appspot.com",
          messagingSenderId: "898247505821",
          appId: "1:898247505821:web:c37cc43eb5d81eae5fa174",
          measurementId: "G-BTP0PN0L68"));
  await GlobalConfiguration().loadFromAsset("configurations");
  //print(CustomTrace(StackTrace.current, message: "base_url: ${GlobalConfiguration().getString('base_url')}"));
  //print(CustomTrace(StackTrace.current, message: "api_base_url: ${GlobalConfiguration().getString('api_base_url')}"));
  //HttpOverrides.global = new MyHttpOverrides();

  settingRepo.initSettings();
  userRepo.getCurrentUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  void initState() {}

  Future<void> authenticationCheck(BuildContext context,
      {VRedirector vRedirector}) async {
    if (userRepo.currentUser.value.auth != true) {
      // ignore: deprecated_member_use
      vRedirector.to('/login',
          queryParameters: {'redirectedFrom': '${vRedirector.to}'});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingRepo.setting,
        builder: (context, Setting _setting, _) {
          return VRouter(
            title: setting.value.appName,
            locale: _setting.mobileLanguage.value,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: _setting.brightness.value == Brightness.light
                ? ThemeData(
                    fontFamily: 'proximanova-regular',
                    primaryColor: Colors.white,
                    disabledColor: Colors.grey,
                    cardColor: Colors.white,
                    secondaryHeaderColor: Color(0xFF043832).withOpacity(1.0),
                    brightness: Brightness.light,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                        secondary: HexColor('#107bd4').withOpacity(1.0)),
                    primaryColorLight: Colors.white,
                    backgroundColor: Colors.white,
                    dividerColor: Color(0xFF8c98a8).withOpacity(0.1),
                    focusColor: Color(0xFF8c98a8).withOpacity(1.0),
                    primaryColorDark: HexColor('#22b1ab'),
                    textTheme: TextTheme(
                      headline5: GoogleFonts.poppins(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.3),
                      headline4: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.3),
                      headline3: GoogleFonts.poppins(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.3),
                      headline2: GoogleFonts.poppins(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.4),
                      headline1: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.4),
                      subtitle1: GoogleFonts.poppins(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.3),
                      subtitle2: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          height: 1.2),
                      headline6: GoogleFonts.poppins(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.3),
                      bodyText2: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.2),
                      bodyText1: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.3),
                      caption: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF8c98a8).withOpacity(1.0),
                          height: 1.7),
                    ),
                  )
                : ThemeData(
                    fontFamily: 'proximanova-regular',
                    brightness: Brightness.dark,
                    scaffoldBackgroundColor: Color(0xFF2C2C2C),
                    primaryColorLight: Colors.white,
                    primaryColor: Color(0xFF2C2C2C),
                    dividerColor: Color(0xFF9999aa).withOpacity(0.1),
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          background: const Color(0xFF000000),
                          onBackground: const Color(0xFF2e2e2e),
                          primary: const Color(0xFF6553D9),
                          onPrimary: const Color(0xFFeeeeee),
                          brightness: Brightness.dark,
                          secondary: HexColor('#ed3733'),
                        ),
                    hintColor: Color(0xFFccccdd).withOpacity(0.1),
                    focusColor: Color(0xFF9999aa).withOpacity(1),
                    primaryColorDark: HexColor('#107bd4'),
                    textTheme: TextTheme(
                      headline5: TextStyle(
                          fontSize: 22.0,
                          color: Color(0xFF9999aa).withOpacity(1),
                          height: 1.3),
                      headline4: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF9999aa).withOpacity(1),
                          height: 1.3),
                      headline3: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF9999aa).withOpacity(1),
                          height: 1.3),
                      headline2: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: HexColor('#ed3733').withOpacity(1.0),
                          height: 1.4),
                      headline1: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFffffff).withOpacity(1),
                          height: 1.4),
                      subtitle1: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9999aa).withOpacity(1),
                          height: 1.3),
                      subtitle2: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF9999aa).withOpacity(1),
                          height: 1.2),
                      headline6: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          color: HexColor('#ed3733').withOpacity(1.0),
                          height: 1.3),
                      bodyText2: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9999aa).withOpacity(1),
                          height: 1.2),
                      bodyText1: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9999aa).withOpacity(1),
                          height: 1.3),
                      caption: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF9999aa).withOpacity(0.6),
                          height: 1.2),
                    ),
                  ),
            debugShowCheckedModeBanner: false,
            routes: [
              VWidget(path: '/login', widget: HomePage()),
              VGuard(
                beforeEnter: (vRedirector) =>
                    authenticationCheck(context, vRedirector: vRedirector),
                stackedRoutes: [
                  VPopHandler(
                    onPop: (_) async => print('POP'),
                    stackedRoutes: [
                      VNester(
                        path: null,
                        name: 'VNester1',
                        widgetBuilder: (child) => MyScaffold(
                          child,
                          title: 'VNester1',
                        ),
                        nestedRoutes: [
                          VWidget(
                            path: '/drecommendation',
                            name: 'drecommendation',
                            widget: DRecommendationPage(),
                            aliases: ['/drecommendation'],
                          ),
                          VWidget(
                            path: '/m416Package',
                            name: 'm416Package',
                            widget: Package(),
                            aliases: ['/m416Package'],
                          ),
                          VWidget(
                            path: '/currency',
                            name: 'currency',
                            widget: CurrencyPage(),
                            aliases: ['/currency'],
                          ),
                          VWidget(
                            path: '/wallet',
                            name: 'wallet',
                            widget: WalletWidget(),
                            aliases: ['/wallet'],
                          ),
                          VWidget(
                            path: '/cashonhand',
                            name: 'cashonhand',
                            widget: CashOnHandPage(),
                            aliases: ['/cashonhand'],
                          ),
                          VWidget(
                            path: '/category',
                            name: 'category',
                            widget: CategoryPage(),
                            aliases: ['/category'],
                          ),
                          VWidget(
                            path: '/sub_category',
                            name: 'category',
                            widget: SubCategoryPage(),
                            aliases: ['/category'],
                          ),
                          VWidget(
                            path: '/roles',
                            name: 'roles',
                            widget: RolesWidget(),
                            aliases: ['/roles'],
                          ),
                          VWidget(
                            path: '/push_notification',
                            name: 'push_notification',
                            widget: PushNotification(),
                            aliases: ['/push_notification'],
                          ),
                          VWidget(
                            path: '/coupon',
                            name: 'coupon',
                            widget: CouponPage(),
                            aliases: ['/coupon'],
                          ),
                          VWidget(
                            path: '/payment_gateway',
                            name: 'payment_gateway',
                            widget: PaymentGateway(),
                            aliases: ['/payment_gateway'],
                          ),
                          VWidget(
                            path: '/Order',
                            name: 'Orders',
                            widget: Orders(),
                            aliases: ['/Orders'],
                          ),
                          VWidget(
                            path: '/takeaway',
                            name: 'Orders',
                            widget: OrdersTakeaway(),
                            aliases: ['/Orders'],
                          ),
                          VWidget(
                            path: '/general_settings',
                            name: 'general_settings',
                            widget: GeneralSettings(),
                            aliases: ['/general_settings'],
                          ),
                          VWidget(
                            path: '/zone',
                            name: 'zone',
                            widget: Zone(),
                            aliases: ['/zone'],
                          ),
                          VWidget(
                            path: '/popup',
                            name: 'popup',
                            widget: Dialogs(),
                            aliases: ['/popup'],
                          ),
                          VWidget(
                            path: '/vendorlist',
                            name: 'vendorlist',
                            widget: VendorList(),
                            aliases: ['/vendorlist'],
                          ),
                          VWidget(
                            path: '/user',
                            name: 'user',
                            widget: User(),
                            aliases: ['/User'],
                          ),
                          VWidget(
                            path: '/shopType',
                            name: 'shopType',
                            widget: ShopTypes(),
                            aliases: ['/User'],
                          ),
                          VWidget(
                            path: '/delivery_tips',
                            name: 'delivery_tips',
                            widget: DeliveryTips(),
                            aliases: ['/delivery_tips'],
                          ),
                          VWidget(
                            path: '/dashboard',
                            name: 'dashboard',
                            widget: DashboardWidget(),
                            aliases: ['/dashboard'],
                          ),
                          VWidget(
                            path: '/driver',
                            name: 'driver',
                            widget: DeliveryBoy(),
                            aliases: ['/driver'],
                          ),
                          VWidget(
                            path: '/deliveryfees',
                            name: 'deliveryfees',
                            widget: DeliveryFee(),
                            aliases: ['/deliveryfees'],
                          ),
                          VWidget(
                            path: '/otherservicedeliveryfees',
                            name: 'deliveryfees',
                            widget: OtherServiceDeliveryFee(),
                            aliases: ['/otherservicedeliveryfees'],
                          ),
                          VWidget(
                            path: '/banner',
                            name: 'banner',
                            widget: Banners(),
                            aliases: ['/banner'],
                          ),
                          VWidget(
                            path: '/review',
                            name: 'review',
                            widget: Review(),
                            aliases: ['/review'],
                          ),
                          VWidget(
                            path: '/vendor',
                            name: 'vendor',
                            widget: VendorList(),
                            aliases: ['/invoice'],
                          ),
                          VWidget(
                            path: '/invoice/:id',
                            name: 'invoice',
                            widget: InvoiceWidget(),
                            aliases: ['/invoice'],
                          ),
                          VWidget(
                            path: '/package',
                            name: 'package',
                            widget: PackagePage(),
                            aliases: ['/package'],
                          ),
                          VWidget(
                            path: '/membership',
                            name: 'membership',
                            widget: Membership(),
                            aliases: ['/membership'],
                          ),
                          VWidget(
                            path: '/vendormap',
                            name: 'vendormap',
                            widget: VendorMapWidget(),
                            aliases: ['/vendormap'],
                          ),
                          VWidget(
                            path: '/bookingdetails',
                            name: 'bookingdetails',
                            widget: BookingDetailsPage(),
                            aliases: ['/bookingdetails'],
                          ),
                          VWidget(
                            path: '/paymentdetails',
                            name: 'paymentdetails',
                            widget: PaymentDetailsPage(),
                            aliases: ['/paymentdetails'],
                          ),
                          VWidget(
                            path: '/managezone',
                            name: 'managezone',
                            widget: ManageZone(),
                            aliases: ['/managezone'],
                          ),
                          VWidget(
                            path: '/supercategory',
                            name: 'supercategory',
                            widget: SuperCategoryPage(),
                            aliases: ['/supercategory'],
                          ),
                          VWidget(
                            path: '/membershiphistory',
                            name: 'membershiphistory',
                            widget: MembershipPlanHistory(),
                            aliases: ['/membershiphistory'],
                          ),
                          VWidget(
                            path: '/commissionreport',
                            name: 'commissionreport',
                            widget: CommissionReport(),
                            aliases: ['/commissionreport'],
                          ),
                          VWidget(
                            path: '/tax',
                            name: 'tax',
                            widget: TaxPage(),
                            aliases: ['/tax'],
                          ),
                          VWidget(
                            path: '/version',
                            name: 'version',
                            widget: VersionControlWidget(),
                            aliases: ['/version'],
                          ),
                          VWidget(
                            path: '/provider',
                            name: 'provider',
                            widget: Provider(),
                            aliases: ['/provider'],
                          ),
                          VWidget(
                            path: '/otherservies',
                            name: 'otherservices',
                            widget: RequestPayments(),
                            aliases: ['/otherservices'],
                          ),
                          VWidget(
                            path: '/policy',
                            name: 'policy',
                            widget: Policy(),
                            aliases: ['/policy'],
                          ),
                          VWidget(
                            path: '/chat',
                            name: 'chat',
                            widget: ChatPage(),
                            aliases: ['/chat'],
                          ),

                          /** VWidget(
                            path: '/bulk_upload',
                            widget: DragDrop(),

                            // Custom transition
                          ), */
                          VWidget(
                            path: '/report',
                            widget: Report(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/profileView',
                            widget: ProfileView(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/language',
                            widget: LanguagesWidget(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/thermalSlip',
                            widget: Slip(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/role',
                            widget: RolePage(),

                            // Custom transition
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              VRouteRedirector(
                redirectTo: '/login',
                path: r':_(.*)',
              ),
            ],
          );
        });
  }
}

class MyCountWidget extends StatelessWidget {

  int notifyCount = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("chatUser")
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          print('No data available.');
          return Text('No data available.');
        } else {
          final count = snapshot.data.docs.length;
          print('Document Count: $count');
          for(int i=0;i<snapshot.data.docs.length;i++){
            DocumentSnapshot chat = snapshot.data.docs[i];
            var shopunRead = chat['shopunRead'];
            print(shopunRead);
            if(chat['shopunRead'] == "false"){
              notifyCount++;
            }
          }
          print('Document Count: $notifyCount');
          return Text('$notifyCount',style: TextStyle(color: Colors.white),);
        }
      },
    );
  }
}

//ignore: must_be_immutable
class MyScaffold extends StatefulWidget {
  Widget vChild;
  String title;

  MyScaffold(
    this.vChild, {
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  toggleDrawer() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openEndDrawer();
    } else {
      _scaffoldKey.currentState.openDrawer();
    }
  }



  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;

    int notifcationCount = 0;

    return WillPopScope(
      onWillPop: () async {
        print('exit');
        return false;
      },
      child: Container(
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              if (!displayMobileLayout)
                AppDrawer(
                  permanentlyDisplay: true,
                ),
              Expanded(
                child: Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    // when the app isn't displaying the mobile version of app, hide the menu button that is used to open the navigation drawer
                    automaticallyImplyLeading: displayMobileLayout,
                    backgroundColor: Theme.of(context).primaryColor,
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    actions: [

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Badge(
                          badgeContent: MyCountWidget(),
                          position: BadgePosition.topEnd(top: 10, end: -5),
                          child: IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              // Handle notification icon tap
                            },
                          ),
                        ),
                      ),
                    ],
                    title: ListTile(
                        contentPadding: EdgeInsets.only(left: 0, right: 0),
                        leading: Wrap(
                          children: [
                            // Wrap(
                            //   children: [
                            //     Container(
                            //       padding: EdgeInsets.only(top: 2),
                            //       child:Image(image: setting.value.language=='English'?
                            //       AssetImage('assets/img/united-states-of-america.png'): setting.value.language=='العربية'?AssetImage('assets/img/united-arab-emirates.png'):
                            //       setting.value.language=='Français - France'?AssetImage('assets/img/france.png'):
                            //       setting.value.language=='Spana'?AssetImage('assets/img/spain.png'):
                            //       setting.value.language=='germen - Canadien'?AssetImage('assets/img/germany.png'):
                            //       setting.value.language=='Malay'?AssetImage('assets/img/malay.png'):
                            //       setting.value.language=='Korean'?AssetImage('assets/img/united-states-of-america.png'):
                            //       setting.value.language=='Chinese'?AssetImage('assets/img/china.png'):
                            //       AssetImage('assets/img/united-states-of-america.png'), height: 20, width: 20),
                            //     ),
                            //
                            //     // InkWell(
                            //     //   onTap: () async {
                            //     //
                            //     //
                            //     //     var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => LanguagesWidget()));
                            //     //
                            //     //     if(result==null) {
                            //     //       setState(() => setting.value);
                            //     //     }
                            //     //   },
                            //     //   child: Padding(
                            //     //     padding: EdgeInsets.only(top: 3, left: 5),
                            //     //     child: Text(setting.value.language, style: Theme.of(context).textTheme.bodyText2),
                            //     //   ),
                            //     // ),
                            //     Icon(Icons.arrow_drop_down,color:Colors.grey),
                            //   ],
                            // ),
                          ],
                        ),
                        trailing: Container(
                          child: Text(userRepo.currentUser.value.name),
                        )),
                  ),
                  drawer: displayMobileLayout
                      ? AppDrawer(
                          permanentlyDisplay: true,
                          callback: this.toggleDrawer,
                        )
                      : null,
                  body: widget.vChild,
                ),
              )
            ],
          )),
    );
  }
}

class SwitchOpen extends StatefulWidget {
  @override
  _SwitchOpenState createState() => _SwitchOpenState();
}

class _SwitchOpenState extends State<SwitchOpen> {
  bool isSwitched = false;

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
      activeColor: Colors.black,
      value: status,
      onChanged: (value) {
        print("VALUE : $value");
        setState(() {
          status = value;
        });
      },
    );

    /*Wrap(
      children:[
        Padding(
          padding: EdgeInsets.only(top:13,right:6),
          child:  Text('Open'),
        ),

        GestureDetector(
          onTap: () {},

          child: Switch(
            value: isSwitched,

            onChanged: (value){
              setState(() {
                isSwitched=value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,


          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:13,left:6),
          child:  Text('Close'),
        ),
      ]
    );*/
  }
}

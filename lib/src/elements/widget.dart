
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';

import 'package:responsive_ui/responsive_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'CardWidget.dart';
import 'package:intl/intl.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

// ignore: must_be_immutable
class ProfileTweets extends StatefulWidget {

  ProfileTweets(this.con);
  @override
  _ProfileTweetsState createState() => _ProfileTweetsState();
  UserController con;
}

final control = TextEditingController();

class _ProfileTweetsState extends State<ProfileTweets>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    widget.con.basicInformationData.openingTime =
        widget.con.profileResponseNew.general.openingTime;
    widget.con.basicInformationData.closingTime =
        widget.con.profileResponseNew.general.closingTime;
    widget.con.basicInformationData.holidays.monVal =
        widget.con.profileResponseNew.general.holidays.monVal;
    widget.con.basicInformationData.holidays.tueVal =
        widget.con.profileResponseNew.general.holidays.tueVal;
    widget.con.basicInformationData.holidays.wedVal =
        widget.con.profileResponseNew.general.holidays.wedVal;
    widget.con.basicInformationData.holidays.thurVal =
        widget.con.profileResponseNew.general.holidays.thurVal;
    widget.con.basicInformationData.holidays.friVal =
        widget.con.profileResponseNew.general.holidays.friVal;
    widget.con.basicInformationData.holidays.satVal =
        widget.con.profileResponseNew.general.holidays.satVal;
    widget.con.basicInformationData.holidays.sunVal =
        widget.con.profileResponseNew.general.holidays.sunVal;
    widget.con.bankModel.businessType =
        widget.con.profileResponseNew.bankDetails.businessType;
    _tabController = TabController(vsync: this, length: 1);

    super.initState();
  }

  int checkedItem = 0;

  Widget checkbox(String title, bool boolValue) {
    return Container();
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     Text(title),
    //     Checkbox(
    //       value: boolValue,
    //       onChanged: (bool value) {
    //         /// manage the state of each value
    //         setState(() {
    //           switch (title) {
    //             case "MON":
    //               widget.con.generalModel.holidays.monVal = value;
    //               widget.con.profileDetails.general.holidays.monVal = value;
    //               break;
    //             case "TUE":
    //               widget.con.generalModel.holidays.tueVal = value;
    //               widget.con.profileDetails.general.holidays.tueVal = value;
    //               break;
    //             case "WED":
    //               widget.con.generalModel.holidays.wedVal = value;
    //               widget.con.profileDetails.general.holidays.wedVal = value;
    //               break;
    //             case "THU":
    //               widget.con.generalModel.holidays.thurVal = value;
    //               widget.con.profileDetails.general.holidays.thurVal = value;
    //               break;
    //             case "FRI":
    //               widget.con.generalModel.holidays.friVal = value;
    //               widget.con.profileDetails.general.holidays.friVal = value;
    //               break;
    //             case "SAT":
    //               widget.con.generalModel.holidays.satVal = value;
    //               widget.con.profileDetails.general.holidays.satVal = value;
    //               break;
    //             case "SUN":
    //               widget.con.generalModel.holidays.sunVal = value;
    //               widget.con.profileDetails.general.holidays.sunVal = value;
    //               break;
    //           }
    //         });
    //       },
    //     )
    //   ],
    // );
  }

  _selectTime(type) async {
    TimeOfDay selectedTime = TimeOfDay(
        hour: int.parse(DateFormat('kk').format(DateTime.now())),
        minute: int.parse(DateFormat('mm').format(DateTime.now())));
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).colorScheme.secondary,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(
                  primary: Theme.of(context).colorScheme.secondary).copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;

        if (type == 'open') {
          widget.con.basicInformationData.openingTime = picked.format(context);
          widget.con.openTime.text = picked.format(context);
        } else {
          widget.con.basicInformationData.closingTime = picked.format(context);
          widget.con.closeTime.text = picked.format(context);
        }

        /**_setTime = timePicker.formatDate(
            DateTime(year, month, day, selectedTime.hour, selectedTime.minute), [timePicker.hh, ':', timePicker.nn, " ", timePicker.am]).toString();
 */
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // MapPicker.init(
    //     theme: MPickerTheme(
    //
    //         /// # Initial Location
    //         initialLocation: LatLng(-23.572143, -46.613275),
    //
    //         /// # Text showed when address is not founded
    //         errorAddressMissing: 'Error, address don\'t founded.',
    //
    //         /// # Text showed when gets error during find address
    //         errorToFindAddress: 'Error to find this address, try again.',
    //
    //         /// # Initial text when don`t has any address selected
    //         withoutAddress: 'Without Address Picked',
    //
    //         /// # Here the texts showed in [TextField] case you don`t use a custom
    //         searchHint: 'Type here...',
    //         searchLabel: 'Search:',
    //
    //         /// # Language of return of google maps api
    //         lang: 'pt-BR'),
    //     key: 'AIzaSyDjJk2l2-0PxawqpgQ2BYVDNRbzqCvHMrw');
    return AppCard(
      margin:EdgeInsets.only(left:size.width>769? 15:0,right:size.width>769? 15:0,bottom:25),
      padding: EdgeInsets.only(bottom: 20),
      child: widget.con.profileResponseNew.general?.storeName == ''
          ? Container()
          : Column(
              children: [
                TabBar(
                   isScrollable: true,
                  controller: _tabController,
                  indicatorColor: Color(0xFF5e078e),
                  unselectedLabelColor: Colors.grey,
                  //labelColor: Colors.black,
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  tabs: [
                    Tab(
                      child: Text(S.of(context).general_details),
                    ),

                  ],
                ),
                SizedBox(
                  height: 600,
                  child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        child: Form(
                          key: widget.con.generalFormKey,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(children: [
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .ownerName = input,
                                                initialValue: widget
                                                    .con
                                                    .profileResponseNew
                                                    .general
                                                    .ownerName,
                                                validator: (input) =>
                                                    input.length <= 1
                                                        ? S
                                                            .of(context)
                                                            .provide_your_name
                                                        : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: "Owner name",
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget.con.basicInformationData.storeName = input,
                                                initialValue: currentUser.value.name,
                                                enabled: true,
                                                validator: (input) => input.length <= 1 ? S.of(context).please_provide_shop_name : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).shop_name,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .companyLegalName = input,
                                                initialValue: widget
                                                    .con
                                                    .profileResponseNew
                                                    .general
                                                    .companyLegalName,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_subtitle
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: S
                                                      .of(context)
                                                      .company_legal_name,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    // Div(
                                    //   colS: 12,
                                    //   colM: 6,
                                    //   colL: 6,
                                    //   child: Padding(
                                    //     padding: EdgeInsets.only(
                                    //         top: 10, left: 20, right: 20),
                                    //     child: Container(
                                    //         width: double.infinity,
                                    //         child: TextFormField(
                                    //             // onSaved: (input) => widget.con.generalModel.companyLegalName = input,
                                    //
                                    //             initialValue: widget
                                    //                 .con
                                    //                 .profileDetails
                                    //                 .general
                                    //                 .business,
                                    //             //validator: (input) =>  input.length<= 1 ? S.of(context).please_select_your_business_type : null,
                                    //             textAlign: TextAlign.left,
                                    //             autocorrect: true,
                                    //             keyboardType:
                                    //                 TextInputType.text,
                                    //             decoration: InputDecoration(
                                    //               labelText: S
                                    //                   .of(context)
                                    //                   .business_type,
                                    //               labelStyle: Theme.of(context)
                                    //                   .textTheme
                                    //                   .bodyText2
                                    //                   .merge(TextStyle(
                                    //                       color: Colors.grey)),
                                    //               enabledBorder:
                                    //                   UnderlineInputBorder(
                                    //                 borderSide: BorderSide(
                                    //                   color: Colors.grey,
                                    //                   width: 1.0,
                                    //                 ),
                                    //               ),
                                    //               focusedBorder:
                                    //                   UnderlineInputBorder(
                                    //                 borderSide: BorderSide(
                                    //                   color: Theme.of(context)
                                    //                       .colorScheme
                                    //                       .secondary,
                                    //                   width: 1.0,
                                    //                 ),
                                    //               ),
                                    //             ))),
                                    //   ),
                                    // ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .subtitle = input,
                                                initialValue: widget
                                                    .con
                                                    .profileResponseNew
                                                    .general
                                                    .subtitle,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_subtitle
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).subtitle,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .subtitle = input,
                                                initialValue:
                                                    currentUser.value.email,
                                                enabled: false,
                                                validator: (input) => !input
                                                        .contains('@')
                                                    ? S
                                                        .of(context)
                                                        .should_be_valid_email
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).email,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .mobile = input,
                                                initialValue:
                                                    currentUser.value.phone,
                                                enabled: false,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).phone,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .mobile = input,
                                                initialValue: widget
                                                    .con
                                                    .profileResponseNew
                                                    .general
                                                    .alterMobile,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: S
                                                      .of(context)
                                                      .alternative_mobile,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                controller: widget.con.openTime,
                                                keyboardType:
                                                    TextInputType.text,
                                                onTap: () {
                                                  _selectTime('open');
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).open_time,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                controller:
                                                    widget.con.closeTime,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                onTap: () {
                                                  _selectTime('close');
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).close_time,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .pickupAddress = input,
                                                initialValue: widget
                                                    .con
                                                    .profileResponseNew
                                                    .general
                                                    .pickupAddress,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_your_address
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).address,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .pinCode = input,
                                                initialValue: widget
                                                    .con
                                                    .profileResponseNew
                                                    .general
                                                    .pinCode,
                                                validator: (input) =>
                                                    input.length <= 1
                                                        ? 'Enter your zipcode'
                                                        : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).zipcode,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .landmark = input,
                                                initialValue: widget
                                                    .con
                                                    .profileResponseNew
                                                    .general
                                                    .landmark,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_enter_your_landmark
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).landmark,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                        colS: 12,
                                        colM: 12,
                                        colL: 12,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 20, right: 20),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                final url =
                                                    'https://www.latlong.net/convert-address-to-lat-long.html';
                                                if (await canLaunch(url)) {
                                                  await launch(
                                                    url,
                                                    forceSafariVC: false,
                                                  );
                                                }
                                                /**  MapPickerTemplate.dialogAddressPicker(
                                                /// # Here you can pass your custom widget to put text and search
                                                  searchBuilder: (search) => Card(child: TextField(decoration: InputDecoration(labelText: 'Search:', hintText: 'Type here...', prefixIcon: IconButton(icon: Icon(Icons.arrow_back_outlined), onPressed: () => Navigator.pop(context)), suffixIcon: IconButton(icon: Icon(Icons.search),
                                                      /// # To search, just call the method `search` passing the address string
                                                      onPressed: () => search(control.text))), controller: control)),
                                                  /// # Here your custom widget to show current selected address
                                                  addressBuilder: (txt, done) => Card(
                                                    /// # Case you want put a button here to done the process, you just need call `done` function
                                                      child: Container(padding: EdgeInsets.all(10), child: Text(txt, textAlign: TextAlign.center))),
                                                  /// # You can to pass your custom marker here
                                                  marker: Icon(Icons.location_pin, color: Colors.redAccent, size: 30),
                                                  /// # Text in negative button
                                                  btnCancel: 'Cancel',
                                                  /// # Text in positive button
                                                  btnSave: 'Save', context: context);*/
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                child: Text("Help"),
                                              ),
                                            ))),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .latitude = input,
                                                initialValue: widget
                                                    .con
                                                    .profileResponseNew
                                                    .general
                                                    .latitude
                                                    .toString(),
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_enter_latitude
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).latitude,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .basicInformationData
                                                    .longitude = input,
                                                initialValue: widget
                                                    .con
                                                    .profileResponseNew
                                                    .general
                                                    .longitude
                                                    .toString(),
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_enter_longitude
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).longitude,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),

                                  ]),
                                  SizedBox(height: 20,),
                                  Center(
                                    child: Container(
                                      width: 120,
                                      height: 45.0,
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).colorScheme.secondary,
                                        borderRadius:
                                            BorderRadius.circular(30),
                                        /*borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))*/
                                      ),
                                      // ignore: deprecated_member_use
                                      child: FlatButton(
                                        onPressed: () {
                                          widget.con.update();
                                        },
                                        child: Center(
                                            child: Text(
                                          S.of(context).submit,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

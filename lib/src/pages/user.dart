import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/elements/AEUserPopUpWIdget.dart';
import 'package:login_and_signup_web/src/elements/AddWalletPopup.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/UserBoxWidget.dart';
import 'package:login_and_signup_web/src/models/user_model.dart';
import 'package:login_and_signup_web/src/pages/searchbox_user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends StateMVC<User> {
  PrimaryUserController _con;

  _UserState() : super(PrimaryUserController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForUser();
    print("commission");
    print(_con.userData.commission);
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
                                colS: 6,
                                colM: 6,
                                colL: 6,
                                child: Wrap(children: [
                                  Text(
                                    S.of(context).manage_users,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  SizedBox(width: 10),
                                  /** Container(
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
                                            AddCategoryHelper.exit(context,_con,UserModel(), 'add');
                                          },
                                        ),
                                      ) */
                                ])),
                            Div(
                              colS: 6,
                              colM: 6,
                              colL: 6,
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
                                                      SearchBoxUser(
                                                        searchType: 'category',
                                                        userList: _con.userList,
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
                    SizedBox(height: 20),
                    _con.userList.isEmpty
                        ? EmptyOrdersWidget()
                        : Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 30),
                            child: Wrap(
                              children:
                                  List.generate(_con.userList.length, (index) {
                                UserModel _userData =
                                    _con.userList.elementAt(index);
                                return InkWell(
                                    onTap: () {
                                      imagepickerbottomsheet(
                                          _con.userList[index].id, _userData);
                                    },
                                    child: UserBoxWidget(
                                      userData: _userData,
                                    ));
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

  imagepickerbottomsheet(id, UserModel categoryDetails) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.adjust_sharp),
                  title: new Text('ID: $id'),
                  onTap: () => {
                    Navigator.pop(context),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () async {
                    await _con.delete('user', id);

                    Navigator.pop(context);
                    setState(() {
                      _con.userList.clear();
                    });
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text("ADD/DEBIT WALLET"),
                  onTap: () async {
                    Navigator.pop(context);
                    AddWalletHelper.exit(
                        context, _con, id, categoryDetails.wallet);
                  },
                ),
              ],
            ),
          );
        });
  }
}

class AddWalletHelper {
  static exit(context, con, id, wallet) => showDialog(
      context: context,
      builder: (context) =>
          AddWalletPopup(con: con, userId: id, wallet: wallet));
}

class AddCategoryHelper {
  static exit(context, con, categoryDetails, pageType) => showDialog(
      context: context,
      builder: (context) => AEUserPopUpWidget(
          con: con, categoryDetails: categoryDetails, pageType: pageType));
}

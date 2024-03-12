import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../../generated/l10n.dart';
import '../../elements/EmptyOrdersWidget.dart';
import '../../models/zone.dart';


class RolePage extends StatefulWidget {
  const RolePage();

  @override
  _RolePageState createState() => _RolePageState();
}

class _RolePageState extends StateMVC<RolePage> {

  UserController _con;

  _RolePageState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listRole();
    _con.listenAdminForZone();
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
                                    "Manage Admin Role",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  SizedBox(width: 10),

                                  SizedBox(width: 10),
                                  Container(
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
                                        _openModal(_con);
                                      },
                                    ),
                                  )
                                ])),

                          ]),
                    ),
                    SizedBox(height: 20),
                    !_con.isApiLoad ?  Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                      child: Wrap(
                        children:List.generate(
                            _con.roleResponse.data.length, (index) {
                          var dataBean = _con.roleResponse.data[index];
                          return InkWell(
                            onTap: () {},
                            child: Div(
                              colS: 12,
                              colM: 6,
                              colL: 3,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5.0,
                                            spreadRadius: 1,
                                          ),
                                        ]),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                width: 37,
                                                height: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/img/userImage.png"),
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
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            dataBean.name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline3,
                                                          ),
                                                          Text(
                                                            dataBean.phone,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        //  CustomDividerView(dividerHeight: 1,),
                                        SizedBox(height: 5),
                                        !dataBean.name.toLowerCase().contains("admin") ? InkWell(
                                          onTap: (){
                                            _con.deleteRole(dataBean.adminId,context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10,left: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.delete, // Specify the icon from the Material Icons library
                                                  size: 28.0, // Set the size of the icon
                                                  color: Colors.red, // Set the color of the icon
                                                )
                                              ],
                                            ),
                                          ),
                                        ):Container()
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        }),
                      ),
                    ):EmptyOrdersWidget(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _openModal(UserController con) async {
    String zoneModel;
    await showDialog(
      context: context,
      builder: (context) {
        String genderValue = 'Male'; // Default gender value

        return Form(
          key: con.formKey, // Use
          child: AlertDialog(
            title: Text('Enter Admin Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    con.name = value;
                  },
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    // Handle name change
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Mobile Number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    con.mobile = value;
                  },
                  decoration: InputDecoration(labelText: 'Mobile Number'),
                  onChanged: (value) {
                    // Handle name change
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    con.email = value;
                  },
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    // Handle name change
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    con.address = value;
                  },
                  decoration: InputDecoration(labelText: 'Address'),
                  onChanged: (value) {
                    // Handle name change
                  },
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    con.password = value;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  onChanged: (value) {
                    // Handle name change
                  },
                ),
                SizedBox(height: 10,),
                Text('Select Zone'),
                // Center(
                //   child: DropdownButton<ZoneModel>(
                //     //isDense: true,
                //     hint: Text('Choose'),
                //     value: zoneModel,
                //     icon: Icon(Icons.check_circle_outline),
                //     iconSize: 24,
                //     elevation: 16,
                //     style: TextStyle(color: Colors.deepPurple),
                //     underline: Container(
                //       height: 2,
                //       color: Colors.blue[300],
                //     ),
                //     onChanged: (ZoneModel newValue) {
                //       setState(() {
                //         zoneModel = newValue;
                //       });
                //     },
                //     items:
                //     con.zoneDataList.map<DropdownMenuItem<ZoneModel>>((ZoneModel value) {
                //       return DropdownMenuItem<ZoneModel>(
                //         value: value,
                //         child: Text(value.id + ' ' + value.id),
                //       );
                //     }).toList(),
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                      hint: Text("Select Zone Id"),
                      value: zoneModel, //
                      isExpanded: true,
                      focusColor: Theme.of(context).colorScheme.secondary,
                      validator: (value) => value == null ? S.of(context).please_select : null,
                      items: con.zoneDataList.map((ZoneModel map) {
                        return new DropdownMenuItem(
                          value: map.id,
                          child: new Text(map.id, style: new TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          //con.shopTypeData.superCategory = value;
                          zoneModel = value;
                        });
                      }),
                ),

              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (con.formKey.currentState.validate()) {
                    con.formKey.currentState.save();
                    con.saveRole(zoneModel);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );

    // if (result != null) {
    //   setState(() {
    //     _selectedPerson = result as Person;
    //   });
    // }
  }

  void showToast(message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be visible
      gravity: ToastGravity.BOTTOM, // Position of the toast message
      backgroundColor: Colors.black54, // Background color of the toast
      textColor: Colors.white, // Text color of the toast
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/i18n.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../models/Dropdown.dart';

class AddWalletPopup extends StatefulWidget {

  AddWalletPopup({this.con,this.userId,this.wallet});

  PrimaryUserController con;
  int userId;
  String wallet;

  @override
  StateMVC<AddWalletPopup> createState() => _AddWalletPopupState();
}

class _AddWalletPopupState extends StateMVC<AddWalletPopup> {

  TextEditingController _walletTextController;
  String _value;
  List<DropDownModel> dropDownList = <DropDownModel>[];

  var _walletKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadWalletType();
    _walletTextController = new TextEditingController();
  }

  loadWalletType(){

    if(widget.wallet != "0") {
      DropDownModel model1 = new DropDownModel();
      model1.name = "Add";
      model1.id = "1";
      dropDownList.add(model1);
      DropDownModel model2 = new DropDownModel();
      model2.name = "Debit";
      model2.id = "2";
      dropDownList.add(model2);
    }else{
      DropDownModel model1 = new DropDownModel();
      model1.name = "Add";
      model1.id = "1";
      dropDownList.add(model1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child:Div(
          colS:12,
          colM:8,
          colL:6,
          child:Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),

            elevation: 0,
            backgroundColor: Colors.transparent,

            insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.2,
              left:MediaQuery.of(context).size.width * 0.09,
              right:MediaQuery.of(context).size.width * 0.09,
              bottom:MediaQuery.of(context).size.height * 0.2,
            ),
            child:Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color:Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child:Container(
                        child:Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children:[
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )

                                      ]
                                  ),


                                  SizedBox(height:10),

                                  Text('Wallet',
                                      style: Theme.of(context).textTheme.headline4
                                  ),

                                  Form(
                                  key: _walletKey,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 18, left:18),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[


                                            SizedBox(height: 40),

                                            Text(
                                             "",
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),
                                            SizedBox(height: 15),
                                            Padding(
                                              padding: EdgeInsets.only(top:10),
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Select Type",
                                                    style:  Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Colors.grey)),
                                                  ),
                                                  DropdownButton(
                                                      value: _value,
                                                      isExpanded: true,
                                                      focusColor: Theme.of(context).colorScheme.secondary,
                                                      style:Theme.of(context).textTheme.subtitle1,
                                                      underline: Container(

                                                        height: 1,
                                                        color: Colors.grey,
                                                      ),
                                                      items: dropDownList.map((DropDownModel map) {
                                                        return new DropdownMenuItem(
                                                          value: map.id,
                                                          child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _value = value;
                                                        });
                                                      }),
                                                ],
                                              ),

                                            ),
                                            SizedBox(height:20),
                                            Padding(
                                              padding: const EdgeInsets.all(0.0),
                                              child: TextFormField(
                                               controller: _walletTextController,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Enter Amount',
                                                ),
                                              ),
                                            ),
                                            SizedBox(height:40),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // ignore: deprecated_member_use
                                                FlatButton(
                                                  onPressed: () {
                                                    if(_walletTextController.text.isEmpty){
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(content: Text('All fields are required.')),
                                                      );
                                                    }else{
                                                      Navigator.pop(context);
                                                      if(_value == "1"){
                                                        _value = "credit";
                                                      }else{
                                                        _value = "debit";
                                                      }
                                                      print("submit");
                                                     widget.con.addDebitWallet(_value, widget.userId,_walletTextController.text.toString());
                                                    }
                                                  },
                                                  padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                  color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                  shape: StadiumBorder(),
                                                  child: Text(
                                                    "Submit",
                                                    style: Theme.of(context).textTheme.headline6.merge(
                                                        TextStyle(
                                                            color: Theme.of(context)
                                                                .primaryColorLight)),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height:30),
                                          ]
                                      ),

                                    ),
                                  ),
                                ]
                            ),
                          ),),
                      )
                  ),




                ],
              ),
            ),
          ),

        )

    );
  }
}

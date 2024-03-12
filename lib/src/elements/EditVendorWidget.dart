

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../generated/l10n.dart';
import '../controllers/primaryuser_controller.dart';

class EditVendorWidget extends StatefulWidget {

  const EditVendorWidget();

  @override
  _EditVendorWidgetState createState() => _EditVendorWidgetState();
}

class _EditVendorWidgetState extends StateMVC<EditVendorWidget> {

  PrimaryUserController _con;

  _EditVendorWidgetState() : super(PrimaryUserController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Div(
        colS:12,
        colM:8,
        colL:6,
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          ),

          elevation: 0,
          backgroundColor: Colors.transparent,

          insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1,
            left:MediaQuery.of(context).size.width * 0.09,
            right:MediaQuery.of(context).size.width * 0.09,
            bottom:MediaQuery.of(context).size.height * 0.05,
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
                                Text("Edit Vendor",
                                    style: Theme.of(context).textTheme.headline4
                                ),

                                Form(
                                  key: _con.diverFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 40, left:40),
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Column(
                                            children: <Widget>[
                                              TextFormField(
                                                  textAlign: TextAlign.left,
                                                 
                                                  validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                                                  autocorrect: true,
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    hintText: S.of(context).first_name,
                                                    hintStyle: Theme.of(context).textTheme.caption,
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey[300],
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Theme.of(context).colorScheme.secondary,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  )),
                                              SizedBox(height: 5),
                                              TextFormField(
                                                  textAlign: TextAlign.left,
                                                  onSaved: (input) => _con.vendorData.shopName = input,
                                                  initialValue: '',
                                                  validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                                                  autocorrect: true,
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    hintText: S.of(context).first_name,
                                                    hintStyle: Theme.of(context).textTheme.caption,
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey[300],
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Theme.of(context).colorScheme.secondary,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),

                                          SizedBox(height: 10),


                                          SizedBox(height:20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // ignore: deprecated_member_use
                                              FlatButton(
                                                onPressed: () {
                                                  //  _con.addBanner();
                                                  //  if(!_con.registerData.isPasswordChange){
                                                  //_con.register(widget.pageType);
                                                  // }else{
                                                  //   Toast.show(
                                                  //     "Enter Password",
                                                  //     context,
                                                  //     duration: Toast.LENGTH_SHORT,
                                                  //     gravity: Toast.BOTTOM,
                                                  //   );
                                                  // }

                                                },
                                                padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                shape: StadiumBorder(),
                                                child: Text(
                                                  S.of(context).submit,
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
      ),
    );
  }
}

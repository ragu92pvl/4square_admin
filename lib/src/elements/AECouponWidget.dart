
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/coupon.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
// ignore: must_be_immutable
class AECouponWidget extends StatefulWidget{
  SecondaryController con;
  Coupon couponDetails;
  String pageType;
  AECouponWidget({Key key, this.con, this.couponDetails, this.pageType}) : super(key: key);
  @override
  _AECouponWidgetState createState() => _AECouponWidgetState();
}

class _AECouponWidgetState extends StateMVC<AECouponWidget> {
  DateTime _selectedDate;
  // ignore: non_constant_identifier_names
  String _Type;
  TextEditingController _textEditingController = TextEditingController();


  TextEditingController title = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController discountType = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController limit = TextEditingController();
  TextEditingController minimumPurchasedAmount = TextEditingController();
  TextEditingController terms = TextEditingController();
  TextEditingController till = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title.text = widget.couponDetails.title;
    discount.text = widget.couponDetails.discount;
    discountType.text = widget.couponDetails.discountType;
    code.text = widget.couponDetails.code;
    limit.text = widget.couponDetails.limit;
    minimumPurchasedAmount.text = widget.couponDetails.minimumPurchasedAmount;
    terms.text = widget.couponDetails.terms;
    till.text = widget.couponDetails.till;

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

                                Form(
                                  key: widget.con.registerFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 18, left:18),
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[

                                          Padding(
                                            padding: EdgeInsets.only(top:10),


                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                   controller: title,
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    //initialValue: widget.details.title,
                                                    onSaved: (input) =>  widget.con.couponData.title = input,
                                                    validator: (input) => input.length < 1 ? 'please_enter_the_title' : null,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: 'Coupon Title',
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Theme.of(context).colorScheme.secondary,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ))),
                                          ),

                                          SizedBox(height: 10),


                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child:Container(
                                              width: double.infinity,
                                              child: DropdownButton(
                                                  value: _Type,
                                                  isExpanded: true,
                                                  focusColor: Theme.of(context).colorScheme.secondary,
                                                  underline: Container(
                                                    color: Colors.grey[300],
                                                    height: 1.0,
                                                  ),
                                                  items: [
                                                       DropdownMenuItem(
                                                        child: Text("Amount"),
                                                        value: '1',
                                                        ),
                                                    DropdownMenuItem(
                                                      child: Text("Percentage"),
                                                      value: '2',
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _Type = value;
                                                      widget.con.couponData.discountType=value;
                                                      //widget.con.bannerData.type = value;
                                                    });
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                              width: double.infinity,
                                              child: TextField(
                                                focusNode: AlwaysDisabledFocusNode(),
                                                decoration: const InputDecoration(
                                                  hintText: 'Enter your coupon validity',
                                                ),
                                                controller: _textEditingController,
                                                onTap: () {
                                                  _selectDate(context);
                                                  setState(() {
                                                    widget.con.couponData.till=_selectedDate.toString();
                                                  });

                                                },
                                              ),),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                  controller: discount,
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,

                                                    onSaved: (input) =>  widget.con.couponData.discount = input,
                                                    validator: (input) => input.length < 1 ? 'please_enter_the_discount' : null,

                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(
                                                          RegExp(r'^(\d+)?\.?\d{0,2}')
                                                      ),
                                                    ],
                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    decoration: InputDecoration(
                                                      labelText: S.of(context).discount,
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Theme.of(context).colorScheme.secondary,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ))),
                                          ),


                                          SizedBox(height: 10),

                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                  controller: minimumPurchasedAmount,
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    onSaved: (input) =>  widget.con.couponData.minimumPurchasedAmount= input,
                                                    validator: (input) => input.length < 1 ? 'please_enter_terms' : null,

                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(
                                                          Helper.getDecimalPointLimit()
                                                      ),
                                                    ],
                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    decoration: InputDecoration(
                                                      labelText: 'Minimum PurchasedAmount',
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Theme.of(context).colorScheme.secondary,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ))),
                                          ),

                                          SizedBox(height: 10),

                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                  controller: terms,
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    onSaved: (input) =>  widget.con.couponData.terms= input,
                                                    validator: (input) => input.length < 1 ? 'please_enter_terms' : null,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: 'Enter Coupon Terms',
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Theme.of(context).colorScheme.secondary,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ))),
                                          ),


                                          SizedBox(height: 10),

                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    controller: code,

                                                    onSaved: (input) =>  widget.con.couponData.code = input,
                                                    validator: (input) => input.length < 1 ? 'S.of(context).please_enter_your_code' : null,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: 'Coupon Code',
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Theme.of(context).colorScheme.secondary,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ))),
                                          ),
                                          SizedBox(height:10),
                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    controller: limit,
                                                    onSaved: (input) =>  widget.con.couponData.limit = input,
                                                    validator: (input) => input.length < 1 ? 'S.of(context).please_enter_your_limit' : null,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: 'Limit',
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Theme.of(context).colorScheme.secondary,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ))),
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            'upload_image',
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            color: Theme.of(context).primaryColor,
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            height: MediaQuery.of(context).size.width * 0.10,
                                            child: GestureDetector(
                                              onTap: () {
                                                Imagepickerbottomsheet();
                                              },
                                              child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                height: double.infinity,
                                                width:double.infinity,
                                                fit: BoxFit.fill,
                                              ): Image.network(_image.path),),
                                          ),
                                          SizedBox(height:20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // ignore: deprecated_member_use
                                              FlatButton(
                                                onPressed: () {
                                                  widget.con.addEdCoupon(context,'Null',widget.pageType);
                                                  // _con.addCar(context,'do_add','null');
                                                },
                                                padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                shape: StadiumBorder(),
                                                child: Text(
                                                  'submit',
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
                        ),
                      )
                  ),




                ],
              ),
            ),
          ),

        )

    );



  }
  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text(S.of(context).camera),
                  onTap: () => getImage(),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text(S.of(context).gallery),
                  onTap: () => getImagegaller(),
                ),
              ],
            ),
          );
        });
  }

  File _image;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {


    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      final pickedFile = await picker.getImage(
          source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          widget.con.couponData.image = pickedFile;
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.couponData.image = _image;
      });

      Navigator.of(context).pop();
    }
  }

  Future getImagegaller() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.con.couponData.image = pickedFile;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      setState(() {
        _selectedDate = newSelectedDate;
      });
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

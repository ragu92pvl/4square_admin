

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AEProviderWidget.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/provider.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';



import 'package:responsive_ui/responsive_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class Provider extends StatefulWidget {
  @override
  _ProviderState createState() => _ProviderState();
}

class _ProviderState extends StateMVC<Provider>  {
  SecondaryController _con;
  List<ProviderModel> providerList=<ProviderModel>[];
  _ProviderState() : super(SecondaryController()) {
    _con = controller;
  }
  bool isSwitched = false;
  int rowsperpage=5;
  List<ProviderModel> itemList=<ProviderModel>[];
  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForProvider();
    itemList=_con.providerList;
    print(providerList.length);
  }

  callback(){
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final _dtSource = UserDataTableSource(
      userData: itemList,
      context: context,
    );
    //itemList.length<10? rowsperpage=5:rowsperpage=10;
    return Container(
      color:Theme.of(context).primaryColor.withOpacity(0.6),
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
                        width: size.width*0.9,
                        margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                        child:Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children:[
                              Div(
                                  colS:6,
                                  colM:6,
                                  colL:6,
                                  child:Wrap(
                                      children:[
                                        Text(
                                          S.of(context).manage_provider,
                                          style: Theme.of(context).textTheme.headline4,
                                        ),
                                        SizedBox(width:10),
                                        InkWell(
                                          onTap:() async {
                                            // ignore: deprecated_member_use
                                            var url = '${GlobalConfiguration().getString('api_base_url')}api_admin/export_action/provider/${currentUser.value.id}';

                                            if (await canLaunch(url)) {
                                              await launch(
                                                url,
                                                forceSafariVC: false,
                                              );
                                            }
                                          },
                                          child: Padding(
                                              padding:EdgeInsets.only(left:8,top:5),
                                              child:Image(image:AssetImage('assets/img/excel.png'),
                                                  width:25,height:25
                                              )
                                          ),
                                        ),
                                        /**  Container(
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
                                            //AddEdPopupHelper.exit(context, _con, ProviderModel(), 'add');
                                            AddEdPopupHelper.exit(context, _con, ProviderModel(), 'add');
                                            },
                                            ),
                                            ), */

                                      ]
                                  )
                              ),
                              /** Container(
                                  width: 150,
                                  height: 30,
                                  child: TextFormField(
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  //initialValue: widget.details.title,
                                  //onSaved: (input) =>  widget.con.bannerData.title = input,
                                  validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                  labelText: S.of(context).search,
                                  labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                  ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                  color:
                                  Theme.of(context).accentColor,
                                  width: 1.0,
                                  ),
                                  ),
                                  )),
                                  ), */

                            ]
                        ),
                      ),
                      itemList.isEmpty?EmptyOrdersWidget():Container(
                        child: CustomPaginatedTable(
                          actions: [
                            Container(
                              height: 40,
                              width: 130,
                              decoration: BoxDecoration(color:Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                                  border:Border.all(
                                      width: 1,
                                      color:Theme.of(context).dividerColor
                                  )
                              ),
                              child: TextFormField(
                                onChanged: (e){
                                  setState((){

                                    itemList =_con.filterProviderUser(_con.providerListTemp, e);

                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  hintText:S.of(context).search,
                                  hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                                  labelText: S.of(context).search,
                                  labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 14)),
                                  suffixIcon: IconButton(
                                    icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                  focusedBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                                ),
                              ),
                            )
                          ],
                          dataColumns: [
                            DataColumn(
                              label: Text('S.NO'),),
                            DataColumn(
                              label: Text(S.of(context).user_name),),
                            DataColumn(
                              label: Text('Dob'),
                            ),
                            DataColumn(
                              label: Text(S.of(context).gender),
                            ),
                            DataColumn(
                              label: Text(S.of(context).email),
                            ),
                            DataColumn(
                              label: Text(S.of(context).mobile),
                            ),
                            DataColumn(
                              label: Text(S.of(context).address),
                            ),
                            DataColumn(
                              label: Text('Working experience'),
                            ),
                            DataColumn(
                              label: Text('Register date'),
                            ),
                            DataColumn(
                              label: Text(S.of(context).status),
                            ),

                          ],
                          //header:  Text('zones'),
                          onRowChanged: (index) => setState(() {rowsperpage=index;}),
                          rowsPerPage: rowsperpage,//_prosvider.rowsPerPage,
                          showActions: true,
                          source: _dtSource,
                          //sortColumnIndex: _provider.sortColumnIndex,
                          //sortColumnAsc: _provider.sortAscending,
                        ),
                      )
                    ])),
          ],
        ),
      ),
    );



  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, Details) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.adjust_sharp),
                  title: new Text('View'),
                  onTap: () => {
                    Navigator.pop(context),

                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                    Navigator.pop(context),
                    //AddEdPopupHelper.exit(context,_con, Details,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    //await _con.delete('shopFocusType',id);

                    Navigator.pop(context);
                    setState(() {_con.shopTypeList.clear();});

                  },
                ),
              ],
            ),
          );
        });
  }
}




class AddEdPopupHelper {

  //static exit(context,con,details, pageType) => showDialog(context: context, builder: (context) =>  AEProviderWidget(con: con,providerDetails: details,pageType: pageType, ));
  static exit(context,con,details, pageType) => showDialog(context: context, builder: (context) =>  AEProviderWidget(con: con,providerDetails: details,pageType: pageType, ));
}

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    List<ProviderModel> userData,

    BuildContext context,


    //this.onRowSelect,
  })  : itemList = userData,
        context=context,

        assert(userData != null);

  final List<ProviderModel> itemList;
  final context;

  //final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= itemList.length) {
      return null;
    }
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text((index+1).toString()??' ')),
        DataCell(Text(itemList[index].username??' ')),
        DataCell(Text(itemList[index].dob??' ')),
        DataCell(Text(itemList[index].gender??' ')),
        DataCell(Text(itemList[index].email??' ')),
        DataCell(Text(itemList[index].mobile??' ')),
        DataCell(Text(itemList[index].address1??' '+' '+itemList[index].address2??' '+' '+itemList[index].city??' '+' '+itemList[index].state??' '+' '+itemList[index].zipcode??' ')),
        DataCell(Text(itemList[index].workingexperience??' ')),
        DataCell(Text(itemList[index].registerdate??' ')),
        DataCell((itemList[index].status=='success')?
        Container(
          decoration:BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(S.of(context).approved),
          ),
        ):Container(
          decoration:BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Blocked'),
          ),))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => itemList.length;

  @override
  int get selectedRowCount => 0;


}
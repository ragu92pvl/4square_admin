
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/cart_responce.dart';
import 'package:login_and_signup_web/src/pages/a4printer.dart';
import 'package:login_and_signup_web/src/pages/slip.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'EmptyOrdersWidget.dart';

// ignore: must_be_immutable
class InvoiceWidget extends StatefulWidget {
  InvoiceWidget({Key key, this.orderID}) : super(key: key);
  int orderID;
  @override
  _InvoiceWidgetState createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends StateMVC<InvoiceWidget> {

  OrderController _con;
  double addonPrice = 0;
  _InvoiceWidgetState() : super(OrderController()) {
    _con = controller;
  }

  int i=0;
  String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con.listenForInvoiceDetails(widget.orderID);
  }

  @override
  Widget build(BuildContext context) {

    //  id = VRouter.of(context).pathParameters['id']??0;


    return _con.invoiceDetailsData.productDetails.isEmpty? EmptyOrdersWidget():Scrollbar(
        isAlwaysShown: true,
        child:ListView(
            scrollDirection:Axis.vertical,
            children:[
              Padding(
                padding:EdgeInsets.only(left:20,right:20,top:20,bottom:20),
                child: Container(
                  padding:EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color:Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20.0,
                          spreadRadius: 5.0,
                        ),
                      ]),

                  child:SingleChildScrollView(
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            IconButton(
                              onPressed:(){
                                Navigator.pop(context);
                              },
                              icon:Icon(Icons.arrow_back),
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text('Invoice',style:Theme.of(context).textTheme.headline6),

                                ),

                                Text('Order#${widget.orderID}')
                              ],
                            ),
                            SizedBox(height:20),
                            Container(
                                decoration:BoxDecoration(
                                    border:Border(
                                        bottom: BorderSide(
                                            width:1,
                                            color:Colors.grey[200]
                                        )
                                    )
                                )
                            ),
                            SizedBox(height:20),
                            Row(
                              children: [
                                Expanded(
                                    child:Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text('Billded to',style:Theme.of(context).textTheme.subtitle1),
                                          SizedBox(height:4),
                                          Text(_con.invoiceDetailsData.addressShop.username),
                                          SizedBox(height:4),
                                          Text(_con.invoiceDetailsData.addressShop.phone),
                                          SizedBox(height:4),
                                          Text(_con.invoiceDetailsData.addressShop.addressSelect),
                                          SizedBox(height:4),


                                        ],
                                      ),
                                    )
                                ),
                                SizedBox(width:MediaQuery.of(context).size.width * 0.1),
                                Expanded(child:Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [

                                      Text('Shipped to',style:Theme.of(context).textTheme.subtitle1),
                                      SizedBox(height:4),
                                      Text(_con.invoiceDetailsData.addressUser.username),
                                      SizedBox(height:4),

                                      Text(_con.invoiceDetailsData.addressUser.phone??''),
                                      SizedBox(height:4),
                                      Text(_con.invoiceDetailsData.addressUser.addressSelect,
                                        textDirection: TextDirection.rtl,
                                      ),




                                    ],
                                  ),
                                ),)
                              ],
                            ),

                            SizedBox(height:20),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child:Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text('Payment Method',style:Theme.of(context).textTheme.subtitle2),
                                          SizedBox(height:4),
                                          Text(_con.invoiceDetailsData.payment.method),




                                        ],
                                      ),
                                    )
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text('Order Date',style:Theme.of(context).textTheme.subtitle2),
                                      SizedBox(height:4),
                                      Text(_con.invoiceDetailsData.orderDate),


                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height:40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order Summary',style:Theme.of(context).textTheme.headline6),
                                SizedBox(height:5),
                                Text('All Itmes here cannot be deleted',style:Theme.of(context).textTheme.caption),





                              ],
                            ),

                            Row(
                                children:[
                                  Expanded(
                                      child:SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        reverse: false,
                                        child:DataTable(
                                          showCheckboxColumn: true,
                                          headingTextStyle: Theme.of(context).textTheme.bodyText1,
                                          columns: [
                                            DataColumn(

                                                label:Text('#')
                                            ),
                                            DataColumn(label:Text('Item'),),
                                            DataColumn(label:Text('Variant/Addon')),
                                            DataColumn(label:Text('Quantity')),
                                            DataColumn(label:Text('Total')),
                                          ],
                                          rows: _con.invoiceDetailsData.productDetails.map((CartResponce map) {
                                            List variantName = [];
                                            addonPrice = 0;
                                            i++;
                                            if(map.addon.length!=0){
                                              map.addon.forEach((element) {
                                                variantName.add(element.name);
                                                //  addonPrice += double.parse(element.price);
                                              });
                                            } else {
                                              variantName.add('no addon');
                                            }

                                            double itemTotal = double.parse(map.price) * map.qty;

                                            return new  DataRow(
                                                cells: [
                                                  DataCell(Text(i.toString())),

                                                  DataCell(

                                                    Row(children:[
                                                      SizedBox(height: 100,),
                                                      Container(
                                                          height: 50,width: 70,
                                                          decoration:BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          padding:EdgeInsets.only(top:5,right: 10),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: Image.network(map.image,
                                                              height: 90,width: double.infinity,fit: BoxFit.fill,
                                                            ),
                                                          )
                                                      ),
                                                      Expanded(
                                                        child:Container(
                                                          child:Text('${map.product_name}')
                                                        )
                                                      )
                                            ])

                                                  ),
                                                  DataCell(Text('${map.variantValue} ${map.unit}')),
                                                  DataCell(Text('x ${map.qty.toString()}')),
                                                  DataCell(Text(Helper.pricePrint(itemTotal))),
                                                ]);
                                          }).toList(),


                                        ),

                                      )
                                  )
                                ]
                            ),

                            SizedBox(height:20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Responsive(
                                    children:[
                                      Div(
                                          colS: 12,
                                          colM:12,
                                          colL:12,
                                          child:Column(
                                              children:[
                                                Wrap(
                                                  children: [
                                                    Div(
                                                      colS:8,
                                                      colM:8,
                                                      colL:8,
                                                      child:Container(
                                                        padding: EdgeInsets.only(right:20),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('Payment Method',style:Theme.of(context).textTheme.headline6),
                                                            Text('The payment method that we provide is to make it easier for you to invoices',style:Theme.of(context).textTheme.caption),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Div(
                                                      colS:4,
                                                      colM:4,
                                                      colL:4,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          /** Text('Subtotal',style:Theme.of(context).textTheme.caption),
                                                              Text(Helper.pricePrint(_con.invoiceDetailsData.payment.sub_total),
                                                              textDirection: TextDirection.rtl,
                                                              style:Theme.of(context).textTheme.headline1),
                                                              SizedBox(height:6),
                                                              Text('Shipping',style:Theme.of(context).textTheme.caption),
                                                              SizedBox(height:10),
                                                              Text(Helper.pricePrint(_con.invoiceDetailsData.payment.grand_total),
                                                              textDirection: TextDirection.rtl,
                                                              style:Theme.of(context).textTheme.headline1), */
                                                          SizedBox(height:10),
                                                          Container(
                                                              decoration:BoxDecoration(
                                                                  border: Border(
                                                                      bottom:BorderSide(
                                                                          width:1,
                                                                          color:Colors.grey[100]
                                                                      )
                                                                  )
                                                              )
                                                          ),
                                                          SizedBox(height:10),

                                                          Text('Packaging charges',
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .caption),
                                                          SizedBox(height: 10),
                                                          Text(
                                                              Helper.pricePrint(_con
                                                                  .invoiceDetailsData
                                                                  .payment
                                                                  .packingCharge)),
                                                          SizedBox(height: 10),
                                                          Text('Delivery Fees',style:Theme.of(context).textTheme.caption),
                                                          SizedBox(height:10),
                                                          Text(Helper.pricePrint(_con.invoiceDetailsData.payment.delivery_fees),
                                                              textDirection: TextDirection.rtl,
                                                              style:Theme.of(context).textTheme.headline1),

                                                          Text('Tips',style:Theme.of(context).textTheme.caption),
                                                          SizedBox(height:10),
                                                          Text(Helper.pricePrint(_con.invoiceDetailsData.payment.delivery_tips),
                                                              textDirection: TextDirection.rtl,
                                                              style:Theme.of(context).textTheme.headline1),
                                                          Text('Tax',style:Theme.of(context).textTheme.caption),
                                                          SizedBox(height:10),
                                                          Text(Helper.pricePrint(_con.invoiceDetailsData.payment.tax),
                                                              textDirection: TextDirection.rtl,
                                                              style:Theme.of(context).textTheme.headline1),
                                                          Text('Total',style:Theme.of(context).textTheme.caption),
                                                          SizedBox(height:10),
                                                          Text(Helper.pricePrint(_con.invoiceDetailsData.payment.grand_total),
                                                              textDirection: TextDirection.rtl,
                                                              style:Theme.of(context).textTheme.headline1),
                                                        ],
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                                SizedBox(height:20),
                                                Container(
                                                    decoration:BoxDecoration(
                                                        border: Border(
                                                            bottom:BorderSide(
                                                                width:1,
                                                                color:Colors.grey[100]
                                                            )
                                                        )
                                                    )
                                                ),
                                                SizedBox(height:40),

                                                Wrap(
                                                    runSpacing: 10,
                                                    children:[

                                                      Div(
                                                          colS:8,
                                                          colM:8,
                                                          colL:6,
                                                          child:Wrap(
                                                              runSpacing: 10,
                                                              children:[
                                                                // ignore: deprecated_member_use
                                                                FlatButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Slip(con: _con.invoiceDetailsData,)));
                                                                    },
                                                                    color:Colors.blue,
                                                                    splashColor:Colors.blue,
                                                                    textColor:Colors.white,
                                                                    child:Wrap(children:[
                                                                      Icon(Icons.payment,size:15,color:Colors.white),
                                                                      SizedBox(width:3),
                                                                      Text('Thermal Printer',style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))
                                                                      ),
                                                                    ])

                                                                ),
                                                                SizedBox(width:5),

                                                              ]
                                                          )
                                                      ),
                                                      Div(
                                                          colS:4,
                                                          colM:4,
                                                          colL:6,
                                                          child:Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children:[
                                                                // ignore: deprecated_member_use
                                                                FlatButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => A4printer(con: _con.invoiceDetailsData,)));
                                                                    },
                                                                    color:Colors.orange,
                                                                    splashColor:Colors.orange,
                                                                    textColor:Colors.white,
                                                                    child:Wrap(children:[
                                                                      Icon(Icons.print,size:15,color:Colors.white),
                                                                      SizedBox(width:3),
                                                                      Text('Print',style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))
                                                                      ),
                                                                    ])

                                                                ),
                                                              ]
                                                          )



                                                      ),

                                                    ]
                                                )

                                              ]
                                          )
                                      ),


                                    ]
                                ),






                              ],
                            ),

                          ]
                      )
                  ),

                ),
              ),
            ]
        )
    );
  }
}

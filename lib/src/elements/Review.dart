import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';

import '../models/VendorList.dart';
import '../repository/user_repository.dart';
import 'PermissionDeniedWidget.dart';
import 'RatingReviewWidget.dart';



class Review extends StatefulWidget {
  const Review({Key key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {

  ShopList vendor = ShopList();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVendor();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : Container(
        width: double.infinity,
        color: Theme.of(context).primaryColorDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 27.0, left: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 30.0),
                  Text('Review',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            vendor.transcationData == null ? Center(
              child: Text('No Data Found'),
            ) : Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.88,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                  ListView.builder(
                  itemCount: vendor.transcationData.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                       return  InkWell(
                         onTap: ()
                         {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  RatingReviews(vendor.transcationData[index].id,vendor.transcationData[index].displayName)),
                           );
                         },
                         child: Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: Row(
                             children: <Widget>[
                               Expanded(
                                 child: Row(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: <Widget>[
                                     CircleAvatar(
                                       backgroundImage: AssetImage('assets/img/userImage.png'),
                                       maxRadius: 30,
                                     ),
                                     SizedBox(
                                       width: 16,
                                     ),
                                     Expanded(
                                       child: Container(
                                         color: Colors.transparent,
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: <Widget>[
                                             Text(vendor.transcationData[index].displayName,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                             SizedBox(
                                               height: 6,
                                             ),
                                             Text(
                                               vendor.transcationData[index].status,
                                               overflow: TextOverflow.ellipsis,maxLines: 2,
                                               style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),

                             ],
                           ),
                         ),
                       );
                    },
                  ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  getVendor() async
  {

    try {
      var url = Uri.parse("${GlobalConfiguration().getString('api_base_url')}Api_admin/vendorList");
      var response = await get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        setState(() {
          vendor = ShopList.fromJson(jsonResponse);

        }
        );

      }
    }
    catch(e) {
      print(e.toString());
    }
  }
}

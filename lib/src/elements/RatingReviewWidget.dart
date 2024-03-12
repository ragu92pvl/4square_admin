import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/product_controller.dart';
import '../repository/user_repository.dart';
import 'EmptyOrdersWidget.dart';
import 'RatingReviewWidget.dart';
import 'ReviewWidget.dart';

// ignore: must_be_immutable
class RatingReviews extends StatefulWidget {
  final String id;
  final String shopName;
  RatingReviews(this.id,this.shopName, {Key key}) : super(key: key);
  @override
  _RatingReviewsState createState() => _RatingReviewsState();
}

class _RatingReviewsState extends StateMVC<RatingReviews> {
  ProductController _con;
  _RatingReviewsState() : super(ProductController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.listenForShopReview(int.parse(widget.id));
  }
  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: HexColor('#ed3733'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        title: Text(widget.shopName + '- Review'),
      ),
      body:(_con.shopReviewList.isEmpty)?EmptyOrdersWidget():Container(
          child:SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
                children:[
                  Container(
                      padding: EdgeInsets.only(top:20,left:15,right:15,bottom:20,),
                      child: RatingsReviewWidget(reviewList: _con.shopReviewList,)
                  ),
                ]
            ),
          )


      ),
    );
  }
}

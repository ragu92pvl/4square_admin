import 'package:flutter/material.dart';

import '../models/shopRating.dart';
import '../models/shopratingmodel.dart';
import 'ReviewBox1Widget.dart';




// ignore: must_be_immutable
class RatingsReviewWidget extends StatefulWidget {
  List<ShopRatingModels> reviewList;
  RatingsReviewWidget({Key key, this.reviewList}) : super(key: key);
  @override
  _RatingsReviewWidgetState createState() => _RatingsReviewWidgetState();
}

class _RatingsReviewWidgetState extends State<RatingsReviewWidget> {



  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        //RatingCircleWidget(),
        ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: widget.reviewList.length,
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.only(top: 25),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, int index) {
            return  ReviewBox1(review: widget.reviewList[index],);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height:7);
          },
        )
      ],
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/shopRating.dart';




// ignore: must_be_immutable
class ReviewBox1 extends StatefulWidget {
  ShopRatingModels review;
  ReviewBox1({Key key,this.review});
  @override
  _ReviewBox1State createState() => _ReviewBox1State();
}

class _ReviewBox1State extends State<ReviewBox1> {


  bool viewMore =true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var date =DateTime.fromMillisecondsSinceEpoch(int.parse(widget.review.date) * 1000).toString();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/img/userImage.png', height: 66,width:66,
                fit: BoxFit.cover,),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.review.buyer,
                      style: TextStyle(color: Colors.black,fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                          widget.review.message,
                          style: TextStyle(color: Colors.black38,fontSize: 12)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: RatingBar.builder(

                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                        ),
                        direction: Axis.horizontal,
                        initialRating: widget.review.rate,
                        unratedColor: Color(0xFF9E9E9E),
                        itemCount: 5,
                        itemSize: 20,
                        glowColor: Colors.black38,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                          date,
                          style: TextStyle(color: Colors.black38,fontSize: 12)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:villivfirebase/admin/admin_orders_page.dart';
import 'package:villivfirebase/screens/Home.dart';
import 'package:villivfirebase/screens/cart_Page.dart';
import 'package:villivfirebase/services/firebase_services.dart';

import '../constants.dart';

class AdminCustomBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hastitle;
  final bool hasBackground;

  AdminCustomBar({this.title,this.hasBackArrow,this.hastitle,this.hasBackground});

  FirebaseServices _firebaseServices = FirebaseServices();



  @override
  Widget build(BuildContext context) {
    bool _hasbackarrow = hasBackArrow??false;
    bool _hasTitle = hastitle??true;
    bool _hasBackground = hasBackground??true;
    return Container(
      decoration: BoxDecoration(
        gradient:_hasBackground? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.03),
          ],
          begin: Alignment(0,0),
          end: Alignment(0,1),
        ):null,
      ),
      padding: EdgeInsets.only(
        top: 50.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_hasbackarrow)
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminOrders()));
              },
              child: Container(
                width:42.0 ,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                    child: Image(
                      image: AssetImage(
                          "assests/images/clipboard@2x.png",

                      ),
                      color: Colors.white,
                      height: 19.0,
                      width: 13.0,
                    )
                ),
              ),
            )
          ,
          if(_hasTitle)
            Text(
              title,
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Container(
              width:42.0 ,
              height: 42.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                  child: Image(
                    image: AssetImage(
                      "assests/images/Path 1394@2x.png",

                    ),
                    color: Colors.white,
                    height: 19.0,
                    width: 13.0,
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}

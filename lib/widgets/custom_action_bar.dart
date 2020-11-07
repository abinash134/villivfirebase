import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:villivfirebase/constants.dart';
import 'package:villivfirebase/screens/cart_Page.dart';
import 'package:villivfirebase/services/firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hastitle;
  final bool hasBackground;

  CustomActionBar({this.title,this.hasBackArrow,this.hastitle,this.hasBackground});

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
                Navigator.pop(context);
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
                      "assests/images/back_arrow@2x.png"
                    ),
                    height: 13.0,
                    width: 7.0,
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
            },
            child: Container(
              width:42.0 ,
              height: 42.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: StreamBuilder(
                  stream: _firebaseServices.usersRef.doc(_firebaseServices.getUserId()).collection("Cart").snapshots(),
                  builder: (context,snapshot){
                    int _totalItems = 0;

                    if(snapshot.connectionState == ConnectionState.active){
                      List _documents = snapshot.data.docs;
                      _totalItems = _documents.length;
                    }

                    return Text(
                      "${_totalItems}"??"0",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

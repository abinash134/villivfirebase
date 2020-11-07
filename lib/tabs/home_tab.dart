import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:villivfirebase/screens/product_page.dart';
import 'package:villivfirebase/widgets/custom_action_bar.dart';
import 'package:villivfirebase/widgets/product_card.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productRef.get(),
            builder: (context, snapshop) {
              if (snapshop.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${snapshop.error}"),
                  ),
                );
              }

              //collection Data ready to display
              if (snapshop.connectionState == ConnectionState.done) {
                //display the data
                return ListView(
                  padding: EdgeInsets.only(
                    top: 100.0,
                    bottom: 12.0,
                  ),
                  children: snapshop.data.docs.map((document) {
                    return  ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()['images'][0],
                      price: "\RS ${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    strokeWidth: 2,
                  ),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Home",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}

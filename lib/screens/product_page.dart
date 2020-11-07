import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:villivfirebase/constants.dart';
import 'package:villivfirebase/services/firebase_services.dart';
import 'package:villivfirebase/widgets/custom_action_bar.dart';
import 'package:villivfirebase/widgets/image_swipe.dart';
import 'package:villivfirebase/widgets/product_size.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  final String productName;
  ProductPage({this.productId,this.productName});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  FirebaseServices _firebaseServices = FirebaseServices();


  String _selectedProductSize = "0";
  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }



  Future _addtoCart(String name) {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize,"name":name});
  }

  final SnackBar _snackBarCart = SnackBar(content: Text("Product added to the cart"),);
  final SnackBar _snackBarSave = SnackBar(content: Text("Product Saved"),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
          future: _firebaseServices.productsRef.doc(widget.productId).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error:${snapshot.error}"),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> productdata = snapshot.data.data();

              List imageList = productdata['images'];
              List ProductSizes = productdata['sizes'];
              _selectedProductSize = ProductSizes[0];

              return ListView(
                padding: EdgeInsets.all(0.0),
                children: [
                  ImageSwipe(imageList: imageList),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${productdata['name']}",
                      style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Rs ${productdata['price']}",
                      style: Constants.regularcolorHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Rs ${productdata['description']}",
                      style: Constants.regularDarkText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select Size",
                      style: Constants.boldHeading,
                    ),
                  ),
                  ProductSize(
                    ProductSizes: ProductSizes,
                    onSelected: (num){

                        _selectedProductSize = num;

                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async{
                            await _addToSaved();
                            Scaffold.of(context).showSnackBar(_snackBarSave);
                          },
                          child: Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: Alignment.center,
                            child: Image(
                              image:
                                  AssetImage("assests/images/tab_saved@2x.png"),
                              height: 22.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: ()async {
                              await _addtoCart("${productdata['name']}");
                              Scaffold.of(context).showSnackBar(_snackBarCart);
                            },
                            child: Container(
                              height: 65.0,
                              margin: EdgeInsets.only(
                                left: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
          hasBackArrow: true,
          hastitle: false,
          hasBackground: false,
        )
      ],
    ));
  }
}

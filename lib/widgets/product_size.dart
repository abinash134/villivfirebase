import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List ProductSizes;
  final Function(String) onSelected;
  ProductSize({this.ProductSizes,this.onSelected});

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  //List ProductSizes = productdata['sizes'];

  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < widget.ProductSizes.length; i++)
          GestureDetector(
            onTap: (){
              widget.onSelected("${widget.ProductSizes[i]}");
              setState(() {
                _selected = i;
              });
            },
            child: Container(
              padding: EdgeInsets.all(2.0),
              margin: EdgeInsets.all(5.0),
              width: 80.0,
              height: 42.0,
              decoration: BoxDecoration(
                color:_selected ==i?Theme.of(context).accentColor: Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                  child: Text(
                "${widget.ProductSizes[i]}",
                style: TextStyle(
                  color:_selected ==i?Colors.white: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              )),
            ),
          )
      ],
    );
  }
}

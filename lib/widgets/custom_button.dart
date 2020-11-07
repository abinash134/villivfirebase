import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outLineButton;
  final bool isLoading;



  CustomButton({this.text, this.onPressed, this.outLineButton, this.isLoading,});

  @override
  Widget build(BuildContext context) {
    bool _outLineButton = outLineButton ?? false;
    bool _isLoading = isLoading ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outLineButton ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: _outLineButton ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

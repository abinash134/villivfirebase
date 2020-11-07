import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:villivfirebase/admin/admin_custom_actionbar.dart';
import 'package:villivfirebase/constants.dart';
import 'package:villivfirebase/widgets/custom_button.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AdminCustomBar(
              title: "Admin Page",
              hasBackArrow: true,
              hastitle: true,
            ),
            GestureDetector(
              onTap: () {
                takeImage(context);
              },
              child: Center(
                child: CustomButton(
                  text: "Click to add Item",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  takeImage(context) {
    return showDialog(
      context: context,
      builder: (con){
        return SimpleDialog(
          title: Text("Add Image",style: Constants.boldHeading,),
          children: [
            SimpleDialogOption(
              child: Text("Capture with Camrera",style: Constants.regularDarkText,),
              onPressed: CapureWithCamera,
            ),
            SimpleDialogOption(
              child: Text("Choose from Gallery",style: Constants.regularDarkText,),
              onPressed: ChoosefromGallery,
            ),
            SimpleDialogOption(
              child: Text("Close",style: Constants.regularDarkText,),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }
  CapureWithCamera()async{
    Navigator.pop(context);
    File imagefile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      file = imagefile;
    });
  }
  ChoosefromGallery()async{
    Navigator.pop(context);
    File imagefile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      file = imagefile;
    });
  }
}

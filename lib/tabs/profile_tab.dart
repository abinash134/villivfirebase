import 'package:flutter/material.dart';
import 'package:villivfirebase/admin/admin_home.dart';
import 'package:villivfirebase/constants.dart';
import 'package:villivfirebase/widgets/custom_action_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:villivfirebase/services/firebase_services.dart';
import 'package:villivfirebase/widgets/custom_button.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool isAdmin = false;
  FirebaseServices _firebaseServices = FirebaseServices();

  _checkAdmin() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(_firebaseServices.getUserId())
        .collection("admin")
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((admin) {
        if (admin.data()['isAdmin'] == true) {
          setState(() {
            isAdmin = true;
          });
        } else {
          setState(() {
            isAdmin = false;
          });
        }
      });
    });
  }

  @override
  void initState() {
    _checkAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          CustomActionBar(
            title: "Profile",
            hasBackArrow: false,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 130.0,
              left: 30.0
            ),
            child: Container(
              child: Text(
                "User Email",
                style: Constants.boldHeading,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            left: 0.0,
            child: isAdmin
                ? CustomButton(
                    text: "Go to Admin Dashboard",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminHome()));
                    },
                  )
                : Text(""),
          )
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:villivfirebase/constants.dart';
import 'package:villivfirebase/screens/Home.dart';
import 'package:villivfirebase/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error:${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot) {
              if (streamsnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${streamsnapshot.error}"),
                  ),
                );
              }
              if(streamsnapshot.connectionState == ConnectionState.active){
                User _user =streamsnapshot.data;
                if(_user == null){
                  return LoginPage();
                }else{
                  return HomePage();
                }
              }
              return Scaffold(
                body: Center(
                  child: Text("checking authentication......"),
                ),
              );
            },
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
    );
  }
}

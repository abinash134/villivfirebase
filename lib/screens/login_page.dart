import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:villivfirebase/admin/admin_login.dart';
import 'package:villivfirebase/constants.dart';
import 'package:villivfirebase/screens/register.dart';
import 'package:villivfirebase/widgets/custom_button.dart';
import 'package:villivfirebase/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {




  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }


  void _submitForm() async {
    // Set the form to loading state
    setState(() {
      _loginFormLoader = true;
    });

    // Run the create account method
    String _loginFeedback = await _loginAccount();

    // If the string is not null, we got error while create account.
    if(_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _loginFormLoader = false;
      });
    }
  }


  bool _loginFormLoader=false;
  String _loginEmail ="";
  String _loginPassword ="";

  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 24.0),
              child: Text(
                "Welcome User,\n Login to your Account.",
                style: Constants.boldHeading,
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: "Email...",

                  onChanged: (value){
                    _loginEmail  = value;
                  },
                  onSubmmit: (value){
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  hintText: "Password...",
                  onChanged: (value){
                    _loginPassword = value;
                  },
                  focusnode: _passwordFocusNode,
                  onSubmmit: (value){
                    _submitForm();
                  },
                ),
                CustomButton(
                  text: "LogIn",
                  onPressed: () {
                      _submitForm();

                  },
                  outLineButton: false,
                  isLoading: _loginFormLoader,
                )
              ],
            ),
            Container(
              child: Column(
                children: [
                  CustomButton(

                    text: "New User Create Account",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (Context)=>RegisterPage()));
                    },
                    outLineButton: true,
                  ),

                ],
              ),
            )




          ],

        ),

      ),
    ));
  }
}

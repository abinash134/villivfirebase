import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:villivfirebase/screens/login_page.dart';
import 'package:villivfirebase/widgets/custom_button.dart';
import 'package:villivfirebase/widgets/custom_input.dart';
import 'package:villivfirebase/services/firebase_services.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  //alert dialoug for show error
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(
                error,
                style: Constants.regularDarkText,
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _registerFormLoading = false;
                    });
                  },
                  child: Text("close"))
            ],
          );
        });
  }
  Future _createAdmin() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("admin")
        .doc(_firebaseServices.getUserId())
        .set({"isAdmin": false});
  }

  Future<String> _createUserwithEmailAndPassword() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password
      );
    } on FirebaseAuthException catch (e) {
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
  void _submitForm()async{
    setState(() {
      _registerFormLoading = true;
    });
    String _createAccountResponce = await _createUserwithEmailAndPassword();
    if(_createAccountResponce !=null){
      _alertDialogBuilder(_createAccountResponce);
      setState(() {
        _registerFormLoading = false;
      });
    }
    else{
      //the string was null ,user is logged in
      Navigator.pop(context);
      _createAdmin();
    }


  }


  //default form loading state
  bool _registerFormLoading = false;
  //form input field values
  String _email="";
  String _password="";

  //Focus node for input fields
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
                "Welcome User,\n Create A New Account.",
                style: Constants.boldHeading,
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: "Email...",

                  onChanged:(value){
                    _email= value;
                  },
                  onSubmmit: (value){
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  hintText: "Password...",
                  onChanged: (value){
                    _password = value;
                  },

                  focusnode: _passwordFocusNode,
                  onSubmmit: (value){
                    _submitForm();
                  },
                ),
                CustomButton(
                  text: "Register",
                  onPressed: () {
                    setState(() {
                      _registerFormLoading =true;
                      _submitForm();

                    });
                  },
                  outLineButton: false,
                  isLoading: _registerFormLoading,
                )
              ],
            ),
            CustomButton(
              text: "Already a User Login",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (Context) => LoginPage()));
              },
              outLineButton: true,
            ),
          ],
        ),
      ),
    ));
    ;
  }
}

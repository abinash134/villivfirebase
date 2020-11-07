import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:villivfirebase/screens/login_page.dart';

class BottomTab extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabpressed;
  BottomTab({this.selectedTab,this.tabpressed});
  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonTabBtn(
            imagepath: "assests/images/tab_home@2x.png",
            selected: _selectedTab == 0?true:false,
            onPressed: (){
              widget.tabpressed(0);
            },
          ),
          ButtonTabBtn(
            imagepath: "assests/images/tab_search@2x.png",
            selected: _selectedTab == 1?true:false,
            onPressed: (){
              widget.tabpressed(1);
            },
          ),
          ButtonTabBtn(
            imagepath: "assests/images/tab_saved@2x.png",
            selected: _selectedTab == 2?true:false,
            onPressed: (){
              widget.tabpressed(2);
            },
          ),
          ButtonTabBtn(
            imagepath: "assests/images/tab_user@2x.png",
            selected: _selectedTab == 3?true:false,
            onPressed: (){
              widget.tabpressed(3);
            },
          ),
          ButtonTabBtn(
            imagepath: "assests/images/tab_logout@2x.png",
            selected: _selectedTab == 4?true:false,
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}

class ButtonTabBtn extends StatelessWidget {
  final String imagepath;
  final bool selected;
  final Function onPressed;

  ButtonTabBtn({this.imagepath, this.selected,this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: _selected ? Theme.of(context).accentColor : Colors.transparent,
          width: 2.0,
        ))),
        child: Image(
          image: AssetImage(
            imagepath,
          ),
          width: 25.0,
          height: 25.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}

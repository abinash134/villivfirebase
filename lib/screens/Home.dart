import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:villivfirebase/constants.dart';
import 'package:villivfirebase/tabs/home_tab.dart';
import 'package:villivfirebase/tabs/profile_tab.dart';
import 'package:villivfirebase/tabs/saved_tab.dart';
import 'package:villivfirebase/tabs/search_tab.dart';
import 'package:villivfirebase/widgets/bottom_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _selectedPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _selectedPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _selectedPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: PageView(
                    controller: _selectedPageController,
                    onPageChanged: (num) {
                      setState(() {
                        _selectedTab = num;
                      });
                    },
                    children: [
                      HomeTab(),
                      SearchTab(),
                      SavedTab(),
                      ProfileTab(),

                    ],
                  )
              ),
              BottomTab(
                selectedTab: _selectedTab,
                tabpressed: (num) {
                  _selectedPageController.animateToPage(
                      num, duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
                },
              ),

            ],
          )
      ),
    );
  }
}

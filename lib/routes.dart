import 'package:flutter/material.dart';
import 'package:villivfirebase/admin/admin_home.dart';
import 'package:villivfirebase/screens/Home.dart';
import 'package:villivfirebase/screens/cart_Page.dart';
import 'package:villivfirebase/screens/login_page.dart';

class Routes{
  Route cart = MaterialPageRoute(builder: (context)=>CartPage());
  Route login = MaterialPageRoute(builder: (context)=>LoginPage());
  Route home = MaterialPageRoute(builder: (context)=>HomePage());
  Route adminhome = MaterialPageRoute(builder: (context)=>AdminHome());
}
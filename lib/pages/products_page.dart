import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsPage extends StatefulWidget {
  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  void _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var storedUser = prefs.getString('user');
    print(json.decode(storedUser));

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('Products Page');
  }
}
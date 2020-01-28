import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductsPage extends StatefulWidget {
  final void Function() onInit;

  ProductsPage({ this.onInit });

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {

  @override
  void initState() {
   
    super.initState();
    widget.onInit();
    // _getUser();
  }

  // void _getUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var storedUser = prefs.getString('user');
  //   print(json.decode(storedUser));

  // }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return state.user != null ? Text(state.user.username) : Text('');
      },
    );
  }
}